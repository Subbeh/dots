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

Func.toggle_special = function()
  if hl.get_active_special_workspace() then
    if hl.get_active_special_workspace().name == "special:term" then
      hl.dispatch(hl.dsp.window.move({ workspace = hl.get_active_workspace().name }))
    end
  else
    hl.dispatch(hl.dsp.window.move({ workspace = "special:term" }))
  end
end

Func.reload_layout = function()
  local count = #hl.get_monitors()
  if count == 1 then
    StartWaybar(Monitors.laptop.name)
  else
    local ext2 = nil
    for _, mon in ipairs(hl.get_monitors()) do
      if mon.description:find(Monitors.ext2.desc, 1, true) then
        ext2 = mon
        break
      end
    end
    StartWaybar(ext2 and ext2.name or Monitors.laptop.name)
  end
  hl.dispatch(hl.dsp.focus({ workspace = "2" }))
end

return Func
