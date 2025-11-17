{ config, pkgs, lib, ... }:

{
  home.file.".config/ashell/config.json".text = ''
    {
      "layer": "top",
      "position": "top",
      "height": 32,
      "spacing": 0,
      "margin-top": 10,
      "margin-right": 10,
      "margin-bottom": 0,
      "margin-left": 10,

      "modules-left": [
        "hyprland/workspaces"
      ],

      "modules-center": [
        "clock"
      ],

      "modules-right": [
        "tray",
        "hyprland/language",
        "cpu",
        "memory",
        "network",
        "pulseaudio",
        "battery"
      ],

      "hyprland/workspaces": {
        "disable-scroll": true,
        "all-outputs": true,
        "format": "{name}",
        "persistent-workspaces": {
          "1": [],
          "2": [],
          "3": [],
          "4": [],
          "5": []
        }
      },

      "tray": {
        "spacing": 10,
        "icon-size": 16
      },

      "clock": {
        "format": "{:%H:%M - %a, %d %b %Y}",
        "tooltip": false
      },

      "cpu": {
        "format": "cpu {usage}%",
        "interval": 2,
        "on-click": "alacritty -e btop"
      },

      "memory": {
        "format": "mem {percentage}%",
        "interval": 2,
        "on-click": "alacritty -e btop"
      },

      "battery": {
        "format": "bat {capacity}%",
        "format-charging": "bat {capacity}%",
        "interval": 5,
        "states": {
          "warning": 20,
          "critical": 10
        },
        "tooltip": false
      },

      "network": {
        "format-wifi": "wifi {bandwidthDownBits}",
        "format-ethernet": "eth {bandwidthDownBits}",
        "format-disconnected": "no network",
        "interval": 5,
        "on-click": "nm-applet",
        "tooltip": false
      },

      "pulseaudio": {
        "scroll-step": 5,
        "max-volume": 150,
        "format": "vol {volume}%",
        "format-bluetooth": "vol {volume}%",
        "format-muted": "vol muted",
        "on-click": "pavucontrol",
        "tooltip": false
      },

      "hyprland/language": {
        "format": "{short}"
      }
    }
  '';

  home.file.".config/ashell/style.css".text = ''
    /* Catppuccin Macchiato Theme */
    * {
      border: none;
      border-radius: 0;
      font-family: "SpaceMono Nerd Font";
      font-size: 12px;
      min-height: 0;
    }

    window#waybar {
      background: #24273a;
      color: #cad3f5;
      border-radius: 7px;
    }

    #workspaces button {
      padding: 0 10px;
      color: #cad3f5;
      background: transparent;
      border-radius: 5px;
    }

    #workspaces button.active {
      background: #363a4f;
      color: #ed8796;
    }

    #workspaces button:hover {
      background: #363a4f;
    }

    #clock,
    #battery,
    #cpu,
    #memory,
    #network,
    #pulseaudio,
    #tray,
    #language {
      padding: 0 10px;
      margin: 0 2px;
      background: #363a4f;
      border-radius: 5px;
    }

    #battery.charging {
      color: #a6da95;
    }

    #battery.warning:not(.charging) {
      color: #eed49f;
    }

    #battery.critical:not(.charging) {
      color: #ed8796;
    }

    #tray > .passive {
      -gtk-icon-effect: dim;
    }

    #tray > .needs-attention {
      -gtk-icon-effect: highlight;
      background-color: #ed8796;
    }
  '';

  home.packages = with pkgs; [
    ashell
  ];
}
