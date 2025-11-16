# Rmenu Configuration
# Application launcher and power menu
# Used on both Hyprland and LeftWM

{ config, pkgs, lib, ... }:

{
  home.file = {
    # Main rmenu configuration
    ".config/rmenu/config.toml".text = ''
      # Rmenu Configuration
      # Catppuccin Macchiato Theme

      [global]
      terminal = "kitty"

      [run]
      prefix = "run"
      use_icons = true

      [drun]
      prefix = "apps"
      use_icons = true
      use_generic = false

      [theme]
      background = "#24273a"
      foreground = "#cad3f5"
      selected_background = "#363a4f"
      selected_foreground = "#ed8796"
      border = "#7dc4e4"
      border_width = 1
      padding = 10
      font = "SpaceMono Nerd Font 12"
      prompt = " "

      [window]
      width = 600
      height = 400
    '';

    # Power menu configuration
    ".config/rmenu/powermenu.toml".text = ''
      # Rmenu Power Menu
      # Catppuccin Macchiato Theme

      [[entry]]
      name = "Shutdown"
      command = "systemctl poweroff"
      icon = ""

      [[entry]]
      name = "Reboot"
      command = "systemctl reboot"
      icon = ""

      [[entry]]
      name = "Suspend"
      command = "systemctl suspend"
      icon = "󰒲"

      [[entry]]
      name = "Lock"
      command = "i3lock-color -c 24273a"
      icon = ""

      [[entry]]
      name = "Logout"
      command = "loginctl kill-session $XDG_SESSION_ID"
      icon = "󰍃"
    '';
  };

  # Install rmenu
  home.packages = with pkgs; [
    rmenu
  ];
}
