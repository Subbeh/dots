--- @class Func
local Func = {}

Func.toggle_hyprexpo = function(action)
  if hl.plugin and hl.plugin.hyprexpo then
    hl.plugin.hyprexpo.expo("toggle")
  else
    action = action or "toggle"
    hl.dispatch(hl.dsp.exec_cmd("hyprctl dispatch \"hl.dsp.exec_raw('hyprexpo:expo " .. action .. "')\""))
  end
end

--- toggle special
Func.toggle_special = function()
  if hl.get_active_special_workspace() then
    if hl.get_active_special_workspace().name == "special:term" then
      hl.dispatch(hl.dsp.window.move({ workspace = hl.get_active_workspace().name }))
    end
  else
    hl.dispatch(hl.dsp.window.move({ workspace = "special:term" }))
  end
end

return Func
