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

function StartWaybar(monitor)
  for _, mon in ipairs(hl.get_monitors()) do
    if monitor == mon.name or monitor == mon.description then
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

function ReloadWaybar()
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
end
