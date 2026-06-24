--- @class Utils
local Utils = {}

Utils.debug = function(msg)
  hl.notification.create({
    text = "DEBUG: " .. tostring(msg),
    timeout = 5000,
  })
  return true
end

Utils.get_monitor = function(query)
  local live = hl.get_monitors()

  for key, cfg in pairs(Monitors) do
    local mon
    for _, m in ipairs(live) do
      if (cfg.name and m.name == cfg.name) or (cfg.desc and m.description:find(cfg.desc, 1, true)) then
        mon = m
        break
      end
    end

    local info = {
      name = key,
      id = mon and mon.name or cfg.name,
      desc = mon and mon.description or cfg.desc,
    }

    if (query.name and query.name == info.name) or (query.id and query.id == info.id) or (query.desc and info.desc and info.desc:find(query.desc, 1, true)) then
      return info
    end
  end

  return nil
end

return Utils
