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

