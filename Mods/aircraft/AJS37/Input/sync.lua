-- DCS Inputs syncing tool
-- Copyright Christoffer "RagnarDa" Wärnbring


dofile("../Cockpit/scripts/devices.lua")
function finddevicename(value)
    for k,v in pairs(devices) do
        if v==value then return k end
    end
end
count = 0

-- Mocked ED functions
function tablelength(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end
function _(t)
	return t
end
function external_profile(t)
    return {keyCommands = {}, axisCommands = {}}
end
function join(t1, t2)
    for i=1,#t2 do
        t1[#t1+1] = t2[i]
    end
    return t1
end
function defaultDeviceAssignmentFor(t)
    return {}
end

function loadkeycommanddefinitions(filename)
    local definitions = dofile(filename).keyCommands
    print("Definitions loaded:")
    print(tablelength(definitions))
    local assignedcount = 0
    -- Let's try checking how many assigned there are
    for o in pairs(definitions) do
        --print(definitions[o].name)
        if definitions[o].combos then assignedcount = assignedcount + 1 end
    end
    print("Assigned count:")
    print(assignedcount)
    return definitions
end

print("\nLoading keyboard definitions...")
folder = "keyboard/"
local keybdefinitions = loadkeycommanddefinitions("keyboard/default.lua")

print("\nLoading joystick definitions...")
folder = "joystick/"
local joydefinitions = loadkeycommanddefinitions("joystick/default.lua")

print("\nLoading mouse definitions...")
folder = "mouse/"
local mousedefinitions = loadkeycommanddefinitions("mouse/default.lua")

local errorsfound = 0
local iCommandsFound = 0

-- Sort the input values
function sortdefinitions(defs)
    if tablelength(defs) > 1 then
        local sort_func = function( a,b )
            -- Sort by category first
            if a.category and b.category then
                if a.category ~= b.category then return a.category < b.category end
            end
            -- Then name
            if a.name and b.name then
                return a.name < b.name
            end
        end
        table.sort(defs, sort_func)
        -- for k in pairs(defs) do print(defs[k].category, defs[k].name, finddevicename(defs[k].cockpit_device_id)) end
    end
end
sortdefinitions(keybdefinitions)
sortdefinitions(joydefinitions)
sortdefinitions(mousedefinitions)

local function comparedefine(defineA, defineB)
    if defineA.down then
        if defineA.down == defineB.down then
            return true
        end      
    end
    if defineA.up then
        if defineA.up == defineB.up then
            return true
        end
    end 
    if defineA.pressed then     
        if defineA.pressed == defineB.pressed then
            return true
        end
    end     
    return false
end

-- Finds the misisng definitions in B
local function comparedefintions(definitionA, definitionB)
    local missing = {}
    for k in pairs(definitionA) do
        local found = false
        for j in pairs(definitionB) do
            if found == false then
                if definitionA[k].cockpit_device_id then
                    -- Uses a cockpit_device_id
                    if definitionB[j].cockpit_device_id == definitionA[k].cockpit_device_id then
                        found = comparedefine(definitionA[k],definitionB[j])
                    end
                else
                    found = comparedefine(definitionA[k],definitionB[j])
                end
            end
        end
        if found == false then
            --print(definitionA[k].name)
            --{down = 3002, cockpit_device_id = devices.NAVIGATIONPANEL, value_down = 1.0, name = "A0 Mode", category = "Radar"},
            local hasanything = false
            local downstr = ""
            if definitionA[k].down then
                if definitionA[k].value_down then
                    downstr = string.format("down = %d, value_down = %f, ", definitionA[k].down, definitionA[k].value_down)
                else
                    downstr = string.format("down = %d, ", definitionA[k].down)
                end
                hasanything = true
            end
            local upstr = ""
            if definitionA[k].up then
                if definitionA[k].value_up then
                    upstr = string.format("up = %d, value_up = %f, ", definitionA[k].up, definitionA[k].value_up)
                else
                    upstr = string.format("up = %d, ", definitionA[k].up)
                end
                hasanything = true
            end
            local pressstr = ""
            if definitionA[k].pressed then
                if definitionA[k].value_pressed then
                    pressstr = string.format("pressed = %d, value_pressed = %f, ", definitionA[k].pressed, definitionA[k].value_pressed)
                else
                    pressstr = string.format("pressed = %d, ", definitionA[k].pressed)
                end
                hasanything = true
            end
            local deviceidstr = ""
            if definitionA[k].cockpit_device_id then
                deviceidstr = string.format("cockpit_device_id = devices.%s, ", finddevicename(definitionA[k].cockpit_device_id))
            end
            local constructed = string.format("{%s%s%s%sname = _('%s'), category = _('%s')},", downstr, upstr, pressstr, deviceidstr, definitionA[k].name, definitionA[k].category)
            --print(constructed)
            if hasanything then 
                table.insert(missing, constructed) 
            else
                --print("*** A possible error was found: No function to do anything! (iCommand ???) ***")
                --print(definitionA[k].name)
                iCommandsFound = iCommandsFound + 1
            end
        end
    end
    return missing
end

-- Unit tests
assert(tablelength(comparedefintions(keybdefinitions, keybdefinitions))==0)
assert(tablelength(comparedefintions(joydefinitions, joydefinitions))==0)
assert(tablelength(comparedefintions(mousedefinitions, mousedefinitions))==0)

print()
print("*** Not found in joystick: ***")
local missinginjoy = comparedefintions(keybdefinitions, joydefinitions)
print(tablelength(missinginjoy))
local iCommandsFoundKeyb = iCommandsFound
iCommandsFound = 0
print()
print("*** Not found in keyboard: ***")
local missinginkeyb = comparedefintions(joydefinitions, keybdefinitions)
print(tablelength(missinginkeyb))
local iCommandsFoundJoy = iCommandsFound
iCommandsFound = 0
print()
print("*** Not found in mouse: ***")
local missinginmouse = comparedefintions(keybdefinitions, mousedefinitions)
print(tablelength(missinginmouse))
print()
print("*** Not found in keyboard from mouse: ***")
local missinginkeybfrommouse = comparedefintions(mousedefinitions, keybdefinitions)
print(tablelength(missinginkeybfrommouse))



if (iCommandsFoundJoy ~= iCommandsFoundKeyb) then 
    print()
    print("*** ERROR ***")
    print("Not matching iCommands for keyboard and joystick.")
    print("These needs to be synced manually.")
    print("Diff:")
    print(iCommandsFoundJoy-iCommandsFoundKeyb)
    errorsfound = errorsfound + 1 
end



file = io.open("missinginjoy.lua", "w")
io.output(file)
for k in pairs(missinginjoy) do
    io.write(missinginjoy[k], "\n")
end
io.close(file)

file = io.open("missinginkeyb.lua", "w")
io.output(file)
for k in pairs(missinginkeyb) do
    io.write(missinginkeyb[k], "\n")
end
for k in pairs(missinginkeybfrommouse) do
    io.write(missinginkeybfrommouse[k], "\n")
end
io.close(file)


file = io.open("missinginmouse.lua", "w")
io.output(file)
for k in pairs(missinginmouse) do
    io.write(missinginmouse[k], "\n")
end
io.close(file)


-- Look for conflicts




print()
print("Errors:")
print(errorsfound)






-- Finally count the missing lines and return it (so a 0 return is everything is fine)
return tablelength(missinginjoy) + tablelength(missinginkeyb) + tablelength(missinginmouse)