local CLASS = "dropterm"
local prev_ws = nil

hl.window_rule({
    match     = { class = "^" .. CLASS .. "$" },
    workspace = "special:dropterm",
    float     = true,
    no_blur   = true,
    size      = { "monitor_w*0.8", "monitor_h*0.5" },
    move      = { "monitor_w*0.1", "0" },
    animation = "slidefadevert -15%",
})

function Dropterm()
    return function()
        local active = hl.get_active_workspace()
        if active and active.name ~= "special:" .. CLASS then
            prev_ws = active.name
        end

        local ws = hl.get_workspace("special:" .. CLASS)
        if ws == nil or ws.is_empty then
            hl.exec_cmd("uwsm app -- kitty --class " .. CLASS
                .. " -o font_size=9 -o window_padding_width='20 10 10 10'"
                .. " -e zsh -c 'tmux new-session -A -s " .. CLASS .. "'")
        else
            hl.dispatch(hl.dsp.workspace.toggle_special(CLASS))
            if prev_ws == "special:term" then
                hl.dispatch(hl.dsp.workspace.toggle_special("term"))
            end
        end
    end
end
