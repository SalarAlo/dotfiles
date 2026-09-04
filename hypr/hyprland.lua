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
