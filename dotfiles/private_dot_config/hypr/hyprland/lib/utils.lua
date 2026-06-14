--- @class Utils
local Utils = {}

Utils.debug = function(msg)
  hl.notification.create({
    text = "DEBUG: " .. tostring(msg),
    timeout = 5000,
  })
  return true
end

return Utils
