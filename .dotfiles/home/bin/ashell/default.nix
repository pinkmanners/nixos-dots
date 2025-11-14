# Ashell Configuration
# Status bar for Wayland/Hyprland
# Replaces Waybar with similar layout and Catppuccin Macchiato theme

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
        "on-click": "kitty -e btop"
      },

      "memory": {
        "format": "mem {percentage}%",
        "interval": 2,
        "on-click": "kitty -e btop"
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
    /* Ashell CSS Theme - Catppuccin Macchiato */

    * {
      font-family: "SpaceMono Nerd Font";
      font-size: 12px;
      border: none;
      border-radius: 0;
      min-height: 0;
    }

    window#ashell {
      background: rgba(36, 39, 58, 0.95);
      border-radius: 12px;
      border: 1px solid #363a4f;
    }

    /* Workspaces */
    #workspaces {
      padding: 0 5px;
      margin: 0 5px;
    }

    #workspaces button {
      padding: 0 8px;
      color: #cad3f5;
      background: transparent;
      border-radius: 8px;
      margin: 4px 2px;
    }

    #workspaces button:hover {
      background: #363a4f;
      color: #cad3f5;
    }

    #workspaces button.active {
      background: #494d64;
      color: #ed8796;
    }

    #workspaces button.urgent {
      background: #ed8796;
      color: #24273a;
    }

    /* Clock */
    #clock {
      padding: 0 10px;
      color: #cad3f5;
      font-weight: bold;
    }

    /* System modules */
    #cpu,
    #memory,
    #network,
    #pulseaudio,
    #battery,
    #language {
      padding: 0 10px;
      margin: 0 2px;
      color: #cad3f5;
      background: transparent;
    }

    #cpu {
      color: #8aadf4;
    }

    #cpu.critical {
      color: #ed8796;
    }

    #memory {
      color: #c6a0f6;
    }

    #memory.critical {
      color: #ed8796;
    }

    #network {
      color: #a6da95;
    }

    #network.disconnected {
      color: #ee99a0;
    }

    #pulseaudio {
      color: #7dc4e4;
    }

    #pulseaudio.muted {
      color: #5b6078;
    }

    #battery {
      color: #eed49f;
    }

    #battery.charging {
      color: #a6da95;
    }

    #battery.warning {
      color: #f5a97f;
    }

    #battery.critical {
      color: #ed8796;
    }

    #language {
      color: #f5bde6;
    }

    /* System tray */
    #tray {
      padding: 0 10px;
    }

    #tray > .passive {
      -gtk-icon-effect: dim;
    }

    #tray > .needs-attention {
      -gtk-icon-effect: highlight;
      background-color: #ed8796;
    }
  '';
}
