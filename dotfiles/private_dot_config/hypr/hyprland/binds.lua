-- SYSTEM
hl.bind("SUPER + SHIFT + R", hl.dsp.exec_cmd("hyprctl reload"))
hl.bind("CTRL + ALT + DELETE", hl.dsp.exec_cmd("uwsm stop"))

-- APPS
hl.bind("SUPER + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind("SUPER + SPACE", hl.dsp.exec_cmd("pkill rofi || __rofi_launcher drun launcher"))

-- WINDOWS
hl.bind("SUPER + Q", hl.dsp.window.close("activewindow"))
hl.bind("SUPER + SHIFT + Q", hl.dsp.window.close("activewindow"))
hl.bind("F9", hl.dsp.window.fullscreen("fullscreen", "toggle", "activewindow"))
hl.bind("F10", hl.dsp.window.fullscreen("maximized", "toggle", "activewindow"))
