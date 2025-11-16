# Kitty Configuration
# Terminal emulator
# Catppuccin Macchiato theme

{ config, pkgs, lib, ... }:

{
  programs.kitty = {
    enable = true;

    font = {
      name = "SpaceMono Nerd Font";
      size = 12;
    };

    settings = {
      # Catppuccin Macchiato Colors
      background = "#24273a";
      foreground = "#cad3f5";
      selection_background = "#5b6078";
      selection_foreground = "#cad3f5";

      cursor = "#f4dbd6";
      cursor_text_color = "#24273a";

      url_color = "#8aadf4";

      # Black
      color0 = "#494d64";
      color8 = "#5b6078";

      # Red
      color1 = "#ed8796";
      color9 = "#ed8796";

      # Green
      color2 = "#a6da95";
      color10 = "#a6da95";

      # Yellow
      color3 = "#eed49f";
      color11 = "#eed49f";

      # Blue
      color4 = "#8aadf4";
      color12 = "#8aadf4";

      # Magenta
      color5 = "#f5bde6";
      color13 = "#f5bde6";

      # Cyan
      color6 = "#8bd5ca";
      color14 = "#8bd5ca";

      # White
      color7 = "#b8c0e0";
      color15 = "#a5adcb";

      # Window settings
      window_padding_width = 10;
      confirm_os_window_close = 0;
      enable_audio_bell = false;

      # Tab bar
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";

      # Performance
      repaint_delay = 10;
      input_delay = 3;
      sync_to_monitor = true;
    };
  };
}
