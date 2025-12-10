{ config, lib, pkgs, ... }:

let
  colors = (import ../../share/colors/catppuccin-macchiato/default.nix { inherit lib; }).colors.catppuccin;
in {
  programs.rofi = {
    enable = true;

    # Use Nerd Font
    font = "Space Mono Nerd Font Bold 12";

    # Terminal for running terminal applications
    terminal = "${pkgs.alacritty}/bin/alacritty";

    # Rofi configuration
    extraConfig = {
      modi = "drun,run,filebrowser,window";
      case-sensitive = false;
      cycle = true;
      filter = "";
      scroll-method = 0;
      normalize-match = true;
      show-icons = true;
      icon-theme = "Papirus";
      steal-focus = false;

      # Matching settings
      matching = "normal";
      tokenize = true;

      # Drun settings
      drun-match-fields = "name,generic,exec,categories,keywords";
      drun-display-format = "{name} [<span weight='light' size='small'><i>({generic})</i></span>]";
      drun-show-actions = false;
      drun-url-launcher = "xdg-open";

      # Window switcher settings
      window-match-fields = "title,class,role,name,desktop";
      window-format = "{w} - {c} - {t:0}";
      window-thumbnail = false;

      # History and Sorting
      disable-history = false;
      sorting-method = "normal";
      max-history-size = 25;

      # Display setting
      display-window = "Windows";
      display-run = "Run";
      display-drun = "Apps";
      display-filebrowser = "Files";

    };

    # Theme configuration
    theme = let
      inherit (config.lib.formats.rasi) mkLiteral;
    in {
      "*" = {
        # Colors
        border-colour = mkLiteral colors.mauve.hex;
        handle-colour = mkLiteral colors.mauve.hex;
        background-colour = mkLiteral colors.base.hex;
        foreground-colour = mkLiteral colors.text.hex;
        alternate-background = mkLiteral colors.surface0.hex;
        normal-background = mkLiteral colors.base.hex;
        normal-foreground = mkLiteral colors.text.hex;
        urgent-background = mkLiteral colors.red.hex;
        urgent-foreground = mkLiteral colors.base.hex;
        active-background = mkLiteral colors.green.hex;
        active-foreground = mkLiteral colors.base.hex;
        selected-normal-background = mkLiteral colors.mauve.hex;
        selected-normal-foreground = mkLiteral colors.base.hex;
        selected-urgent-background = mkLiteral colors.green.hex;
        selected-urgent-foreground = mkLiteral colors.base.hex;
        selected-active-background = mkLiteral colors.red.hex;
        selected-active-foreground = mkLiteral colors.base.hex;
        alternate-normal-background = mkLiteral colors.base.hex;
        alternate-normal-foreground = mkLiteral colors.text.hex;
        alternate-urgent-background = mkLiteral colors.red.hex;
        alternate-urgent-foreground = mkLiteral colors.base.hex;
        alternate-active-background = mkLiteral colors.green.hex;
        alternate-active-foreground = mkLiteral colors.base.hex;
        alt-border1 = mkLiteral colors.sapphire.hex;
      };

      # Main Window
      "window" = {
        transparency = "real";
        location = mkLiteral "center";
        anchor = mkLiteral "center";
        fullscreen = false;
        width = mkLiteral "600px";
        x-offset = mkLiteral "0px";
        y-offset = mkLiteral "0px";
        enabled = true;
        margin = mkLiteral "0px";
        padding = mkLiteral "0px";
        border = mkLiteral "1px solid";
        border-radius = mkLiteral "7px";
        border-color = mkLiteral "@border-colour";
        cursor = "default";
        background-color = mkLiteral "@background-colour";
      };

      # Main Box
      "mainbox" = {
        enabled = true;
        spacing = mkLiteral "10px";
        margin = mkLiteral "0px";
        padding = mkLiteral "30px";
        border = mkLiteral "0px solid";
        border-radius = mkLiteral "0px";
        border-color = mkLiteral "@border-colour";
        background-color = mkLiteral "transparent";
        children = map mkLiteral [ "inputbar" "message" "listview" ];
      };

      # Inputbar
      "inputbar" = {
        enabled = true;
        spacing = mkLiteral "10px";
        margin = mkLiteral "0px";
        padding = mkLiteral "5px";
        border = mkLiteral "1px solid";
        border-radius = mkLiteral "7px";
        border-color = mkLiteral "@border-colour";
        background-color = mkLiteral "@alternate-background";
        text-color = mkLiteral "@foreground-colour";
        children = map mkLiteral [ "textbox-prompt-colon" "entry" "mode-switcher" ];
      };

      "prompt" = {
        enabled = true;
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "inherit";
      };

      "textbox-prompt-colon" = {
        enabled = true;
        padding = mkLiteral "5px";
        expand = false;
        str = "";
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "inherit";
      };

      "entry" = {
        enabled = true;
        padding = mkLiteral "5px 0px";
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "inherit";
        cursor = mkLiteral "text";
        placeholder = "Search...";
        placeholder-color = mkLiteral "inherit";
      };

      # Listview
      "listview" = {
        enabled = true;
        columns = 1;
        lines = 8;
        cycle = true;
        dynamic = true;
        scrollbar = false;
        layout = mkLiteral "vertical";
        reverse = false;
        fixed-height = true;
        fixed-columns = true;
        spacing = mkLiteral "5px";
        margin = mkLiteral "0px";
        padding = mkLiteral "5px";
        border = mkLiteral "1px solid";
        border-radius = mkLiteral "7px";
        border-color = mkLiteral "@alt-border1";
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@foreground-colour";
        cursor = "default";
      };

      "scrollbar" = {
        handle-width = mkLiteral "5px";
        handle-color = mkLiteral "@handle-colour";
        border-radius = mkLiteral "10px";
        background-color = mkLiteral "@alternate-background";
      };

      # Elements
      "element" = {
        enabled = true;
        spacing = mkLiteral "10px";
        margin = mkLiteral "0px";
        padding = mkLiteral "5px 10px";
        border = mkLiteral "0px solid";
        border-radius = mkLiteral "7px";
        border-color = mkLiteral "@border-colour";
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@foreground-colour";
        cursor = mkLiteral "pointer";
      };

      "element normal.normal" = {
        background-color = mkLiteral "var(normal-background)";
        text-color = mkLiteral "var(normal-foreground)";
      };

      "element normal.urgent" = {
        background-color = mkLiteral "var(urgent-background)";
        text-color = mkLiteral "var(urgent-foreground)";
      };

      "element normal.active" = {
        background-color = mkLiteral "var(active-background)";
        text-color = mkLiteral "var(active-foreground)";
      };

      "element selected.normal" = {
        background-color = mkLiteral "var(selected-normal-background)";
        text-color = mkLiteral "var(selected-normal-foreground)";
      };

      "element selected.urgent" = {
        background-color = mkLiteral "var(selected-urgent-background)";
        text-color = mkLiteral "var(selected-urgent-foreground)";
      };

      "element selected.active" = {
        background-color = mkLiteral "var(selected-active-background)";
        text-color = mkLiteral "var(selected-active-foreground)";
      };

      "element alternate.normal" = {
        background-color = mkLiteral "var(alternate-normal-background)";
        text-color = mkLiteral "var(alternate-normal-foreground)";
      };

      "element alternate.urgent" = {
        background-color = mkLiteral "var(alternate-urgent-background)";
        text-color = mkLiteral "var(alternate-urgent-foreground)";
      };

      "element alternate.active" = {
        background-color = mkLiteral "var(alternate-active-background)";
        text-color = mkLiteral "var(alternate-active-foreground)";
      };

      "element-icon" = {
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "inherit";
        size = mkLiteral "24px";
        cursor = mkLiteral "inherit";
      };

      "element-text" = {
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "inherit";
        highlight = mkLiteral "inherit";
        cursor = mkLiteral "inherit";
        vertical-align = mkLiteral "0.5";
        horizontal-align = mkLiteral "0.0";
      };

      # Mode Switcher
      "mode-switcher" = {
        enabled = true;
        spacing = mkLiteral "10px";
        margin = mkLiteral "0px";
        padding = mkLiteral "0px";
        border = mkLiteral "0px solid";
        border-radius = mkLiteral "0px";
        border-color = mkLiteral "@border-colour";
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@foreground-colour";
      };

      "button" = {
        padding = mkLiteral "5px 10px";
        border = mkLiteral "1px solid";
        border-radius = mkLiteral "7px";
        border-color = mkLiteral "@alt-border1";
        background-color = mkLiteral "@background-colour";
        text-color = mkLiteral "inherit";
        cursor = mkLiteral "pointer";
      };

      "button selected" = {
        border-color = mkLiteral "@urgent-background";
        background-color = mkLiteral "var(urgent-background)";
        text-color = mkLiteral "var(selected-normal-foreground)";
      };

      # Message
      "message" = {
        enabled = true;
        margin = mkLiteral "0px";
        padding = mkLiteral "0px";
        border = mkLiteral "0px solid";
        border-radius = mkLiteral "0px";
        border-color = mkLiteral "@border-colour";
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@foreground-colour";
      };

      "textbox" = {
        padding = mkLiteral "8px 10px";
        border = mkLiteral "0px solid";
        border-radius = mkLiteral "7px";
        border-color = mkLiteral "@border-colour";
        background-color = mkLiteral "@alternate-background";
        text-color = mkLiteral "@foreground-colour";
        vertical-align = mkLiteral "0.5";
        horizontal-align = mkLiteral "0.0";
        highlight = mkLiteral "none";
        placeholder-color = mkLiteral "@foreground-colour";
        blink = true;
        markup = true;
      };

      "error-message" = {
        padding = mkLiteral "10px";
        border = mkLiteral "2px solid";
        border-radius = mkLiteral "7px";
        border-color = mkLiteral "@border-colour";
        background-color = mkLiteral "@background-colour";
        text-color = mkLiteral "@foreground-colour";
      };
    };
  };

  # Powermenu script
  home.file.".local/bin/rofi-powermenu" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      # Options
      shutdown=' shutdown'
      reboot=' reboot'
      lock=' lock'
      suspend=' suspend'
      logout=' logout'

      # Rofi command
      chosen=$(echo -e "$lock\n$suspend\n$logout\n$reboot\n$shutdown" | \
        ${pkgs.rofi}/bin/rofi -dmenu -i -p "power menu" \
        -theme-str 'window {width: 400px;}' \
        -theme-str 'listview {lines: 5;}')

      # Execute based on choice
      case $chosen in
        $shutdown)
          systemctl poweroff
          ;;
        $reboot)
          systemctl reboot
          ;;
        $lock)
          ${pkgs.hyprlock}/bin/hyprlock
          ;;
        $suspend)
          systemctl suspend
          ;;
        $logout)
          hyprctl dispatch exit
          ;;
      esac
    '';
  };
}
