function DynamicLayout()
  return function()
    if #hl.get_monitors() ~= 3 then
      return
    end

    local ws = hl.get_workspace(1)
    if ws == nil or ws.monitor == nil then
      return
    end

    local monitor = ws.monitor
    local tiled = hl.get_windows({ workspace = 1, floating = false })
    local reserved = #tiled == 1 and math.floor(monitor.width / monitor.scale * 0.4) or 0

    hl.monitor({ output = monitor.name, reserved_area = { top = 0, right = 0, bottom = 0, left = reserved } })
  end
end
