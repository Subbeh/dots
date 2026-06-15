-- stylua: ignore start
-- SYSTEM
hl.bind("SUPER + SHIFT + R",        hl.dsp.exec_cmd("hyprctl reload"))
hl.bind("CTRL + ALT + DELETE",      hl.dsp.exec_cmd("uwsm stop"))

-- APPS
hl.bind("SUPER + RETURN",           hl.dsp.exec_cmd(TERM))
hl.bind("SUPER + SPACE",            hl.dsp.exec_cmd("pkill rofi || __rofi_launcher drun launcher"))

-- WINDOWS
hl.bind("SUPER + Q",                hl.dsp.window.close("activewindow"))
hl.bind("SUPER + SHIFT + Q",        hl.dsp.window.close("activewindow"))
hl.bind("F9",                       hl.dsp.window.fullscreen("fullscreen", "toggle", "activewindow"))
hl.bind("F10",                      hl.dsp.window.fullscreen("maximized",  "toggle", "activewindow"))
hl.bind("ALT + SHIFT + TAB",        hl.dsp.window.cycle_next("next"))
hl.bind("CTRL + TAB",               hl.dsp.exec_cmd("__rofi_launcher window windows"))
hl.bind("SUPER + F",                hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + H",                hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + L",                hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + K",                hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + J",                hl.dsp.focus({ direction = "down" }))
hl.bind("SUPER + mouse:272",        hl.dsp.window.drag())
hl.bind("SUPER + mouse:273",        hl.dsp.window.resize())

--- swap windows
hl.bind("SUPER + code:34",          hl.dsp.window.swap({ next = 1 }))
hl.bind("SUPER + code:35",          hl.dsp.window.swap({ prev = 1 }))

-- WORKSPACES
hl.bind("SUPER + TAB",              hl.dsp.focus({ workspace = "previous" }))
hl.bind("ALT + TAB",                hl.dsp.workspace.toggle_special("term"))
hl.bind("SUPER + SHIFT + TAB",      function() Func.toggle_hyprexpo() end)
hl.bind("SUPER + S",                function() Func.toggle_special() end)
hl.bind("F12",                      Dropterm())
hl.bind("SUPER + CTRL + H",         hl.dsp.focus({ workspace = "e-1" }))
hl.bind("SUPER + CTRL + L",         hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER + CTRL + SHIFT + H", hl.dsp.window.move({ workspace = "e-1" }))
hl.bind("SUPER + CTRL + SHIFT + L", hl.dsp.window.move({ workspace = "e+1" }))
for i = 1,                          9 do
  hl.bind("SUPER + " .. i,          hl.dsp.focus({ workspace = i }))
  hl.bind("SUPER + SHIFT + " .. i,  hl.dsp.window.move({ workspace = i }))
end

-- WAYBAR
hl.bind("SUPER + CTRL + 1",         function() StartWaybar(Monitors.laptop.name) end)
hl.bind("SUPER + CTRL + 2",         function() StartWaybar(Monitors.ext1.desc) end)
hl.bind("SUPER + CTRL + 3",         function() StartWaybar(Monitors.ext2.desc) end)

-- GESTURES
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
hl.gesture({ fingers = 3, direction = "up",         action = function() Func.toggle_hyprexpo("enable") end })
hl.gesture({ fingers = 3, direction = "down",       action = function() Func.toggle_hyprexpo("cancel") end })
