hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("GTK_THEME", "Adwaita:dark")


hl.on("hyprland.start", function()
  hl.exec_cmd("waybar -c ~/.config/waybar/config.json -s ~/.config/waybar/style.css &")
  hl.exec_cmd("mako")
  hl.exec_cmd("$HOME/.config/hypr/set-wallpaper.sh")
end)


