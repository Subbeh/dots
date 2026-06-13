-- stylua: ignore start
-- SYSTEM
hl.bind("SUPER + SHIFT + R",   hl.dsp.exec_cmd("hyprctl reload"))
hl.bind("CTRL + ALT + DELETE", hl.dsp.exec_cmd("uwsm stop"))

-- APPS
hl.bind("SUPER + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind("SUPER + SPACE",  hl.dsp.exec_cmd("pkill rofi || __rofi_launcher drun launcher"))

-- WINDOWS
hl.bind("SUPER + Q",         hl.dsp.window.close("activewindow"))
hl.bind("SUPER + SHIFT + Q", hl.dsp.window.close("activewindow"))
hl.bind("F9",                hl.dsp.window.fullscreen("fullscreen", "toggle", "activewindow"))
hl.bind("F10",               hl.dsp.window.fullscreen("maximized",  "toggle", "activewindow"))
hl.bind("ALT + SHIFT + TAB", hl.dsp.window.cycle_next("next"))
hl.bind("CTRL + TAB",        hl.dsp.exec_cmd("__rofi_launcher window windows"))
hl.bind("SUPER + SHIFT + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + H",         hl.dsp.focus({direction = "left"}))
hl.bind("SUPER + L",         hl.dsp.focus({direction = "right"}))
hl.bind("SUPER + K",         hl.dsp.focus({direction = "up"}))
hl.bind("SUPER + J",         hl.dsp.focus({direction = "down"}))

--- swap windows
hl.bind("SUPER + code:34", hl.dsp.window.swap({ next = 1 }))
hl.bind("SUPER + code:35", hl.dsp.window.swap({ prev = 1 }))

-- WORKSPACES
for i = 1, 9 do
    hl.bind("SUPER + " .. i,         hl.dsp.focus({workspace = i}))
    hl.bind("SUPER + SHIFT + " .. i, hl.dsp.window.move({workspace = i}))
end
hl.bind("SUPER + TAB", hl.dsp.focus({ workspace = "previous" }))
hl.bind("ALT + TAB", hl.dsp.workspace.toggle_special("term"))
-- hl.bind("F12", hl.dsp.exec_cmd("__hypr_dropterm_launcher"))

--- toggle special
hl.bind("SUPER + S", function ()
  if hl.get_active_special_workspace() then
    if hl.get_active_special_workspace().name == "special:term" then
      hl.dispatch(hl.dsp.window.move({ workspace = hl.get_active_workspace().name }))
    end
  else
    hl.dispatch(hl.dsp.window.move({ workspace = "special:term"}))
  end
end)

--- toggle dropterm

-- PLUGINS

--- hyprexpo
hl.bind("CTRL + TAB", function()
    if hl.plugin and hl.plugin.hyprexpo then
        hl.plugin.hyprexpo.expo("toggle")
    else
        hl.dispatch(hl.dsp.exec_cmd("hyprctl dispatch \"hl.dsp.exec_raw('hyprexpo:expo toggle')\""))
    end
end)
