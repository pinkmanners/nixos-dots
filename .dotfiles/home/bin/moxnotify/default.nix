{ config, pkgs, lib, ... }:

{
  home.file.".config/moxnotify/config.toml".text = ''
    # Moxnotify Configuration
    # Catppuccin Macchiato Theme

    [global]
    # Position on screen
    position = "top-right"

    # Offset from edge
    offset_x = 10
    offset_y = 42

    # Notification dimensions
    width = 350
    height = 100

    # Timeout in milliseconds (0 = never expire)
    timeout = 5000

    # Maximum notifications to show
    max_notifications = 5

    [style]
    # Catppuccin Macchiato colors
    background = "#24273a"
    foreground = "#cad3f5"
    border_color = "#7dc4e4"
    border_width = 1
    border_radius = 7

    # Font
    font = "SpaceMono Nerd Font 11"

    # Padding
    padding = 10

    # Urgency colors
    [style.urgency.low]
    border_color = "#7dc4e4"

    [style.urgency.normal]
    border_color = "#7dc4e4"

    [style.urgency.critical]
    border_color = "#ed8796"
    background = "#24273a"
    foreground = "#ed8796"
  '';

  home.packages = with pkgs; [
    moxnotify
  ];
}
