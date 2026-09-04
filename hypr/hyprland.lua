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
