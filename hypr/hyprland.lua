hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("GTK_THEME", "Adwaita:dark")


hl.on("hyprland.start", function()
  hl.exec_cmd("waybar -c ~/.config/waybar/config.json -s ~/.config/waybar/style.css &")
  hl.exec_cmd("mako")
  hl.exec_cmd("$HOME/.config/hypr/set-wallpaper.sh")
end)


local main_mod = "SUPER"
local terminal = "kitty"

local function register_curves(curves_table)
  for curve, curve_spec in pairs(curves_table) do
    hl.curve(curve, curve_spec)
  end
end

local function register_monitors(monitors_table)
  for _, monitor in pairs(monitors_table) do
    hl.monitor(monitor)
  end
end

local function register_anims(anims_tree)
  for anim_leaf, anim_spec in pairs(anims_tree) do
    hl.animation({
      leaf = anim_leaf,
      enabled = anim_spec.onoff,
      speed = anim_spec.speed,
      bezier = anim_spec.curve,
      style = anim_spec.style,
    })
  end
end

local function register_keybinds(keybibdings, rep)
  rep = rep or false
  for key, action in pairs(keybibdings) do
    hl.bind(key, action, { repeating = rep })
  end
end

local monitors = {
  primaryMonitor = {
    output = "HDMI-A-2",
    mode = "preferred",
    position = "0x0",
    scale = 1
  },
  secondaryMonitor = {
    output = "HDMI-A-1",
    mode = "preferred",
    position = "1920x0",
    scale = 1
  },
}

register_monitors(monitors)


hl.config({
  input = {
    kb_layout = "de",
    follow_mouse = 1,
    sensitivity = 0,
    touchpad = {
      natural_scroll = false,
    }
  },
  general = {
    gaps_in = 5,
    gaps_out = 5,
    border_size = 2,
    col = {
      active_border = {
        colors = { "rgba(ffffffff)", "rgba(ffffffff)" },
        angle = 45,
      },
      inactive_border = "rgba(00000000)",
    },
    resize_on_border = false,
    allow_tearing = false,
    layout = "dwindle",
  },
  animations = {
    enabled = true
  },
  decoration = {
    rounding = 5,
    rounding_power = 2,
    active_opacity = 1,
    inactive_opacity = .98,

    shadow = {
      enabled = false
    },

    blur = {
      enabled = false
    },
  },
  dwindle = {
    preserve_split = true
  },

  master = {
    new_status = "master",
  },
  group = {
    col = {
      border_active = "rgba(ffffffff)",
      border_inactive = "rgba(ffffff66)",
      border_locked_active = "rgba(ffffffff)",
      border_locked_inactive = "rgba(ffffff66)",
    },

    groupbar = {
      text_color = "rgba(ffffffff)",
      col = {
        active = "rgba(ffffffff)",
        inactive = "rgba(ffffff66)",
        locked_active = "rgba(ffffffff)",
        locked_inactive = "rgba(ffffff66)",
      }
    }
  },

  misc = {
    force_default_wallpaper = -1,
    disable_hyprland_logo = false,
  }

})

hl.device({
  name = "epic-mouse-v1",
  sensitivity = -0.5
})

local curves = {
  ["smoothOut"] = {
    type = "bezier",
    points = {
      { 0.25, 0.9 },
      { 0.35, 1.0 },
    }
  },
  ["smoothInOut"] = {
    type = "bezier",
    points = {
      { 0.4, 0.0 },
      { 0.2, 1.0 },
    },
  },
  ["subtle"] = {
    type = "bezier",
    points = {
      { 0.22, 0.9 },
      { 0.3,  1.0 },
    }
  },
  ["stylish"] = {
    type = "bezier",
    points = {
      { 0.2,  1.0 },
      { 0.15, 1.0 },
    }
  },
}

register_curves(curves)


local animations = {
  ["windows"] = {
    onoff = true,
    speed = 6,
    curve = "stylish",
    style = "popin 96%",
  },
  ["windowsOut"] = {
    onoff = true,
    speed = 5,
    curve = "smoothInOut",
    style = "popin 96%",
  },
  ["border"] = {
    onoff = true,
    speed = 9,
    curve = "subtle"
  },
  ["fade"] = {
    onoff = true,
    speed = 5,
    curve = "smoothInOut",
  },
  ["layersIn"] = {
    onoff = true,
    speed = 5,
    curve = "subtle",
    style = "slide bottom",
  },
  ["layersOut"] = {
    onoff = true,
    speed = 4,
    curve = "smoothInOut",
    style = "slide bottom",
  },
  ["fadeLayersIn"] = {
    onoff = true,
    speed = 4,
    curve = "subtle",
  },
  ["fadeLayersOut"] = {
    onoff = true,
    speed = 4,
    curve = "smoothInOut",
  },
  ["workspaces"] = {
    onoff = true,
    speed = 6,
    curve = "stylish",
    style = "slide",
  },
}

register_anims(animations)


local keybinds = {
  [main_mod .. " + S"] = hl.dsp.exec_cmd("hyprshot -m region"),
  [main_mod .. " + Z"] = hl.dsp.exec_cmd("woomer"),
  [main_mod .. " + V"] = hl.dsp.exec_cmd("~/.local/bin/screenrecord-toggle.sh"),
  [main_mod .. " + D"] = hl.dsp.exec_cmd("rofi -show drun"),
  [main_mod .. " + RETURN"] = hl.dsp.exec_cmd(terminal),
  [main_mod .. " + Q"] = hl.dsp.window.kill(),
  [main_mod .. " + SHIFT + Q"] = hl.dsp.window.close(),
  [main_mod .. " + H"] = hl.dsp.focus({ direction = "left" }),
  [main_mod .. " + J"] = hl.dsp.focus({ direction = "down" }),
  [main_mod .. " + K"] = hl.dsp.focus({ direction = "up" }),
  [main_mod .. " + L"] = hl.dsp.focus({ direction = "right" }),
  [main_mod .. " + SHIFT + H"] = hl.dsp.window.move({ direction = "left" }),
  [main_mod .. " + SHIFT + J"] = hl.dsp.window.move({ direction = "down" }),
  [main_mod .. " + SHIFT + K"] = hl.dsp.window.move({ direction = "up" }),
  [main_mod .. " + SHIFT + L"] = hl.dsp.window.move({ direction = "right" }),
  [main_mod .. " + F"] = hl.dsp.window.float(),
  [main_mod .. " + R"] = hl.dsp.exec_cmd("hyprctl reload"),
  [main_mod .. " + SHIFT + R"] = hl.dsp.exec_cmd("$HOME/.config/hypr/set-wallpaper.sh"),
  [main_mod .. " + mouse:272"] = hl.dsp.window.move(),
  [main_mod .. " + mouse:273"] = hl.dsp.window.resize(),
  [main_mod .. " + T"] = hl.dsp.group.toggle(),
  [main_mod .. " + TAB"] = hl.dsp.group.next(),
  [main_mod .. " + SHIFT + TAB"] = hl.dsp.group.prev(),
  [main_mod .. " + SHIFT + T"] = hl.dsp.window.move({ out_of_group = true, }),
  [main_mod .. " + 0"] = hl.dsp.focus({ workspace = "0" }),
  [main_mod .. " + SHIFT + 0"] = hl.dsp.window.move({ workspace = "0" }),
  [main_mod .. " + E"] = hl.dsp.submap("resize"),
}

for i in 1, 9 do
  hl.bind(
    main_mod .. " + " .. tostring(i),
    hl.dsp.focus({ workspace = tostring(i) })
  )
end


for i in 1, 9 do
  hl.bind(
    main_mod .. " + SHIFT + " .. tostring(i),
    hl.dsp.window.move({ workspace = tostring(i) })
  )
end

register_keybinds(keybinds)

hl.define_submap("resize", function()
  local submap_actions = {
    ["H"] = hl.dsp.window.resize({ relative = true, x = -30, y = 0 }),
    ["J"] = hl.dsp.window.resize({ relative = true, x = 30, y = 0 }),
    ["K"] = hl.dsp.window.resize({ relative = true, x = 0, y = -30 }),
    ["L"] = hl.dsp.window.resize({ relative = true, x = 0, y = 30 }),
  }
  local reset_binds = {
    [main_mod .. " + R"] = hl.dsp.submap("reset"),
    ["ESCAPE"] = hl.dsp.submap("reset"),
    ["RETURN"] = hl.dsp.submap("reset")
  }
  register_keybinds(submap_actions, true)
  register_keybinds(reset_binds)
end)

hl.window_rule({
  match = {
    class = "^(origo)$"
  },
  workspace = "4",
})


hl.window_rule({
  match = {
    class = "^(origo)$"
  },
  workspace = "4",
})

hl.window_rule({
  match = {
    class = "^(kitty)$"
  },
  opacity = "0.90 0.98"
})

hl.window_rule({
  match = {
    class = "^(unmanaged)$"
  },
  float = true,
  move = { 5, 50 },
  size = { 1900, 1000 },
})


hl.window_rule({
  match = {
    class = "^(Godot)$"
  },
  tile = true
})


hl.window_rule({
  match = {
    class = ".*"
  },
  suppress_event = "maximize"
})
