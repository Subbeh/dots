hl.workspace_rule({ workspace = "1", persistent = true, monitor = "desc:" .. Monitors.ext1.desc })
hl.workspace_rule({ workspace = "2", persistent = true, monitor = "desc:" .. Monitors.ext2.desc, default = true })
hl.workspace_rule({ workspace = "3", persistent = true, monitor = Monitors.laptop.name })
