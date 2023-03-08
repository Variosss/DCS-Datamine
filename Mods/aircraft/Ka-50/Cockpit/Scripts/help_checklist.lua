dofile(LockOn_Options.script_path.."devices.lua")

function clear()
    clear_checklist()
    rows = {}
end

function set_row(row,action,status)
    set_checklist_row(row,action,status)
    rows[row + 1] = {action,status}
    set_active_row(row)
end

function set_next_row(action,status)   set_row(#rows,action,status) end

clear()
set_next_row("Hello","OK")
set_next_row("Looser","OK")
set_next_row("Good bye","NO")

function on_visibility(visible)

dbg_print("help window visibility \n")

end
