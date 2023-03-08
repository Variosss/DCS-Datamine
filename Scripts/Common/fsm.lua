local base = _G

module('fsm')

__index = base.getfenv()

state				= nil
data 				= nil
PUSH_TO_STACK 		= 1
REPLACE_STACK_TOP 	= 2
CLEAR_STACK 		= 3
POP_FROM_STACK 		= 4

function new(self, data_, handler_, recepient_, name_)
	local newFsm = {}
	newFsm.data = data_
	newFsm.handler = handler_
	newFsm.recepient = recepient_
	newFsm.name = name_
	base.setmetatable(newFsm, self)	
	newFsm:reset()
	return newFsm
end

function reset(self)
	if self.data then
		self.state = self.data.init_state
		--base.console.out('FSM '..self.name..' '..base.tostring(self)..' state '..self.state)
	end
end

function onSymbol(self, inputSymbol)
	--base.console.out('FSM '..self.name..' '..base.tostring(self)..' state before '..base.tostring(self.state))
	--base.console.out('FSM '..self.name..' '..base.tostring(self)..' on symbol '..base.tostring(inputSymbol))
	
	local transition = nil	
	local stateTransitions = self.data.transitions[self.state]
	if stateTransitions then
		--old state-dependent transition
		transition = stateTransitions[inputSymbol]	
	end
	if 	not transition and 
		self.data.initStateFreeTransitions then
		--old state-independent transition
		transition = self.data.initStateFreeTransitions[inputSymbol]
	end
	
	if transition then
			
		--stack operations	
		local stackOp = transition.stackOption
		if stackOp == self.PUSH_TO_STACK then
			if self.stateStack == nil then
				self.stateStack = {}
			end				
			base.table.insert(self.stateStack, self.state)
		elseif stackOp == self.REPLACE_STACK_TOP then
			if self.stateStack == nil then
				self.stateStack = {}
			end				
			self.stateStack[#self.stateStack] = self.state				
		elseif stackOp == CLEAR_STACK then
			self.stateStack = {}
		end
		
		--new state		
		local newState = nil
		if stackOp == self.POP_FROM_STACK then
			local stackDepth = transition.stackDepth or 1
			if self.stateStack then				
				for i = 1, stackDepth do
					newState = self.stateStack[#self.stateStack]
					base.table.remove(self.stateStack, #self.stateStack)
				end
			end
		else
			newState = transition.newState
		end
		
		--exit from old state
		local stateChanged = false
		if newState ~= nil and newState ~= self.state then				
			if self.data.on_state_exit then
				local onExitSymbol = self.data.on_state_exit[self.state]
				if onExitSymbol then			
					if self.recepient then
						self.handler(self.recepient, onExitSymbol)
					end
				end
			end
			--state change
			self.state = newState
			stateChanged = true
		end
		
		--transition symbol
		local outputSymbol = transition.outSymbol
		if outputSymbol ~= nil then
			--base.console.out('FSM '..self.name..' '..base.tostring(self)..' out symbol '..base.tostring(outputSymbol))
			if self.recepient then
				self.handler(self.recepient, outputSymbol)
			end
		end
		
		--enter to new state
		if stateChanged then
			if self.data.on_state_enter then
				local onEnterSymbol = self.data.on_state_enter[newState]
				if onEnterSymbol then			
					if self.recepient then
						self.handler(self.recepient, onEnterSymbol)
					end
				end
			end				
		end
	end
	--base.console.out('FSM '..self.name..' '..base.tostring(self)..' state after '..base.tostring(self.state))
end
