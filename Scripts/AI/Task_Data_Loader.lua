local function makeConstantNames(dst, src)
	for i, v in pairs(src) do
		dst[v] = i
	end
end

function loadTask(task_name)
	local fileName =  "Scripts\\AI\\Tasks\\"..task_name..".lua"
	local f, errorMsg = loadfile(fileName)
	if	  f 	then
		local tbl = {}
		setfenv(f, tbl)
		f()
		tbl.ConditionNames = {}
		makeConstantNames(tbl.ConditionNames, tbl.Conditions)
		tbl.StateNames = {}
		makeConstantNames(tbl.StateNames, tbl.States)		
		tbl.SubtaskNames = {}
		makeConstantNames(tbl.SubtaskNames, tbl.Subtasks)
		return tbl
	else
		error(errorMsg)
	end
end
	
taskToPreLoad = {
	"Follow_Line",
	"Follow_Vector",
	"Follow_Vector_Old",
	"Approach",
	"Cannon_Ground_Attack",
	"Rocket_Attack",
	"Level_Bombing",
	"Dive_Bombing",
	"Missile_Ground_Target_Attack",
	"Missile_Ground_Target_Level_Attack"
}
