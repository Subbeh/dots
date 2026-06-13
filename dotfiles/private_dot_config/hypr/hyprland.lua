terminal = "kitty"
fileManager = "thunar"

require("hyprland.config")
require("hyprland.exec")
require("hyprland.binds")

-- stylua: ignore start
hl.monitor({ output = "eDP-1",                                         mode = "1920x1200@60", position = "0x0",        scale = 1 })
hl.monitor({ output = "desc:LG Electronics LG ULTRAFINE 504NTUW6F878", mode = "3840x2160@60", position = "0x-1800",    scale = 1.25 })
hl.monitor({ output = "desc:LG Electronics LG HDR 4K 308NTTQFK265",    mode = "3840x2160@60", position = "3072x-1800", scale = 1.25 })
