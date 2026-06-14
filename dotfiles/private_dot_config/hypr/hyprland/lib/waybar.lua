local Utils = require("hyprland.lib.utils")

-- local EXT2_DESC = Monitors.ext2.output:gsub("^desc:", "")
local CONFIG_PATH = os.getenv("HOME") .. "/.cache/waybar/config"
local CONFIG_TMPL = [[
[
  {
    "output": "@@OUTPUT@@",
    "include": [
      "~/.config/waybar/config_top",
    ]
  },
  {
    "output": "@@OUTPUT@@",
    "include": [
      "~/.config/waybar/config_bottom"
    ]
  }
]
]]

function ReloadWaybar(monitor)
  for _, mon in ipairs(hl.get_monitors()) do
    if monitor == mon.name or monitor == mon.description then
      Utils.debug(mon.name)

      os.execute("mkdir -p " .. os.getenv("HOME") .. "/.cache/waybar")
      local f = io.open(CONFIG_PATH, "w")
      if f then
        f:write(CONFIG_TMPL:gsub("@@OUTPUT@@", mon.name))
        f:close()
      end
    end
  end

  hl.exec_cmd("systemctl --user restart waybar")
end

-- ReloadWaybar("eDP-1")
ReloadWaybar(Monitors["ext1"].desc)

-- local function find_ext2()
--     for _, m in ipairs(hl.get_monitors()) do
--         if m.description:find(EXT2_DESC, 1, true) then
--             return m
--         end
--     end
--     return nil
-- end
--
-- function RestartWaybar()
--     local ext2   = find_ext2()
--     local output = ext2 and ext2.name or Monitors.laptop.output
--
--     os.execute("mkdir -p " .. os.getenv("HOME") .. "/.cache/waybar")
--     local f = io.open(CONFIG_PATH, "w")
--     if f then
--         f:write(CONFIG_TMPL:gsub("@@OUTPUT@@", output))
--         f:close()
--     end
--
--     hl.exec_cmd("systemctl --user restart waybar")
-- end
--
-- hl.on("monitor.added",   RestartWaybar)
-- hl.on("monitor.removed", RestartWaybar)
-- hl.on("hyprland.start",  RestartWaybar)
