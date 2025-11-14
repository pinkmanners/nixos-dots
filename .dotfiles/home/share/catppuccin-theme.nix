{ config, pkgs, lib, ... }:

{
  # This module provides consistent Catppuccin Macchiato theming across all hosts
  # It can be imported in home/hosts/<hostname>.nix files
  
  options.catppuccin-theme = {
    enable = lib.mkEnableOption "Apply Catppuccin Macchiato theme";
    
    iconVariant = lib.mkOption {
      type = lib.types.str;
      default = "Flatery-Red-Dark";
      description = "Flatery icon theme variant to use";
      example = "Flatery-Blue-Dark";
    };
    
    cursorVariant = lib.mkOption {
      type = lib.types.str;
      default = if config.wayland.windowManager.hyprland.enable then "Mocu-White-Left-H" else "Mocu-White-Left-X";
      description = "Mocu cursor variant to use";
    };
    
    cursorSize = lib.mkOption {
      type = lib.types.int;
      default = 32;
      description = "Cursor size in pixels";
    };
  };

  config = lib.mkIf config.catppuccin-theme.enable {
    # GTK theme configuration
    gtk = {
      enable = true;
      
      theme = {
        name = "Catppuccin-Macchiato-Mauve";
        package = pkgs.magnetic-catppuccin-gtk;
      };
      
      iconTheme = {
        name = config.catppuccin-theme.iconVariant;
        package = pkgs.flatery-icon-theme;
      };
      
      cursorTheme = {
        name = config.catppuccin-theme.cursorVariant;
        package = pkgs.mocu-cursors;
        size = config.catppuccin-theme.cursorSize;
      };
      
      font = {
        name = "SpaceMono Nerd Font";
        size = 11;
      };

      gtk3.extraConfig = {
        gtk-application-prefer-dark-theme = true;
      };

      gtk4.extraConfig = {
        gtk-application-prefer-dark-theme = true;
      };
    };

    # Qt theme configuration (Kvantum)
    qt = {
      enable = true;
      platformTheme.name = "kvantum";
      style = {
        name = "kvantum";
        package = pkgs.catppuccin-kvantum;
      };
    };

    # Set Kvantum theme
    xdg.configFile."Kvantum/kvantum.kvconfig".text = ''
      [General]
      theme=Catppuccin-Macchiato-Mauve
    '';

    # Ensure color scheme files are available
    home.file.".local/share/color-schemes/CatppuccinMacchiato.colors".source = 
      "${pkgs.catppuccin-kde}/share/color-schemes/CatppuccinMacchiato.colors";

    # Apply to various applications via environment variables
    home.sessionVariables = {
      GTK_THEME = "Catppuccin-Macchiato-Mauve";
      QT_STYLE_OVERRIDE = "kvantum";
    };
  };
}
