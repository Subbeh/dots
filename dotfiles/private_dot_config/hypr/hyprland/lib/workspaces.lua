local MON_LAPTOP = Monitors.laptop.output
local EXT1_DESC = Monitors.ext1.output:gsub("^desc:", "")
local EXT2_DESC = Monitors.ext2.output:gsub("^desc:", "")

hl.workspace_rule({ workspace = "1", persistent = true })
hl.workspace_rule({ workspace = "2", persistent = true })
hl.workspace_rule({ workspace = "3", persistent = true })

local lid_closed = false
local applying = false

local function find_monitor(desc_fragment)
  for _, m in ipairs(hl.get_monitors()) do
    if m.description:find(desc_fragment, 1, true) then
      return m
    end
  end
  return nil
end

local function apply_layout()
  if applying then
    return
  end
  applying = true

  local ext1 = find_monitor(EXT1_DESC)
  local ext2 = find_monitor(EXT2_DESC)
  local laptop = hl.get_monitor(MON_LAPTOP)
  local docked = ext1 ~= nil and ext2 ~= nil

  if docked and lid_closed then
    -- disable laptop screen; workspaces 1 on left, 2-3 on right
    hl.monitor({ output = MON_LAPTOP, disabled = true })
    hl.dispatch(hl.dsp.workspace.move({ workspace = 1, monitor = ext1 }))
    hl.dispatch(hl.dsp.workspace.move({ workspace = 2, monitor = ext2 }))
    hl.dispatch(hl.dsp.workspace.move({ workspace = 3, monitor = ext2 }))
  elseif docked then
    -- workspace 1 on left, 2 on right, 3 on laptop
    hl.dispatch(hl.dsp.workspace.move({ workspace = 1, monitor = ext1 }))
    hl.dispatch(hl.dsp.workspace.move({ workspace = 2, monitor = ext2 }))
    if laptop then
      hl.dispatch(hl.dsp.workspace.move({ workspace = 3, monitor = laptop }))
    end
  else
    -- undocked: all on laptop
    if laptop then
      hl.dispatch(hl.dsp.workspace.move({ workspace = 1, monitor = laptop }))
      hl.dispatch(hl.dsp.workspace.move({ workspace = 2, monitor = laptop }))
      hl.dispatch(hl.dsp.workspace.move({ workspace = 3, monitor = laptop }))
    end
  end

  applying = false
end

hl.on("monitor.added", function()
  apply_layout()
end)
hl.on("monitor.removed", function()
  apply_layout()
end)

-- lid closed: disable laptop screen and redistribute workspaces
hl.bind("switch:on:Lid Switch", function()
  lid_closed = true
  apply_layout()
end, { locked = true })

-- lid opened: re-enable laptop screen; monitor.added fires and calls apply_layout
hl.bind("switch:off:Lid Switch", function()
  lid_closed = false
  hl.monitor(Monitors.laptop)
end, { locked = true })

hl.on("hyprland.start", apply_layout)
