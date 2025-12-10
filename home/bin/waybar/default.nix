{ config, lib, pkgs, ... }:

let
  colors = (import ../../share/colors/catppuccin-macchiato/default.nix { inherit lib; }).colors.catppuccin;
in {
  programs.waybar = {
    enable = true;
    systemd.enable = true;

    settings = {
      mainBar = {
        layer = "top";
        spacing = 0;
        height = 0;

        margin-top = 5;
        margin-right = 5;
        margin-bottom = 0;
        margin-left = 5;

        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "clock" ];
        modules-right = [
          "cpu"
          "memory"
          "network"
          "pulseaudio"
          "battery"
          "tray"
        ];

        "hyprland/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
          tooltip = false;
        };

        tray = {
          spacing = 10;
          tooltip = false;
        };

        clock = {
          format = "{:%a, %d %b – %H:%M}";
          tooltip = false;
          on-click = "";
        };

        cpu = {
          format = "   {usage}% ";
          interval = 5;
          states = {
            critical = 90;
          };
          on-click = "btop";
        };

        memory = {
          format = "   {percentage}% ";
          interval = 5;
          states = {
            critical = 80;
          };
        };

        battery = {
          format = "   {capacity}% ";
          format-charging = "  {capacity}% ";
          interval = 60;
          states = {
            warning = 20;
            critical = 10;
          };
          tooltip = false;
        };

        network = {
          format-wifi = "   {bandwidthDownBits} ";
          format-ethernet = "  {bandwidthDownBits} ";
          format-disconnected = "no network";
          interval = 5;
          on-click = "nm-applet";
          tooltip = false;
        };

        pulseaudio = {
          scroll-step = 5;
          max-volume = 150;
          format = "   {volume}% ";
          format-bluetooth = "  {volume}% ";
          nospacing = 1;
          on-click = "pavucontrol";
          tooltip = false;
        };
      };
    };

    style = ''
      @define-color rosewater ${colors.rosewater.hex};
      @define-color flamingo ${colors.flamingo.hex};
      @define-color pink ${colors.pink.hex};
      @define-color mauve ${colors.mauve.hex};
      @define-color red ${colors.red.hex};
      @define-color maroon ${colors.maroon.hex};
      @define-color peach ${colors.peach.hex};
      @define-color yellow ${colors.yellow.hex};
      @define-color green ${colors.green.hex};
      @define-color teal ${colors.teal.hex};
      @define-color sky ${colors.sky.hex};
      @define-color sapphire ${colors.sapphire.hex};
      @define-color blue ${colors.blue.hex};
      @define-color lavender ${colors.lavender.hex};
      @define-color text ${colors.text.hex};
      @define-color subtext1 ${colors.subtext1.hex};
      @define-color subtext0 ${colors.subtext0.hex};
      @define-color overlay2 ${colors.overlay2.hex};
      @define-color overlay1 ${colors.overlay1.hex};
      @define-color overlay0 ${colors.overlay0.hex};
      @define-color surface2 ${colors.surface2.hex};
      @define-color surface1 ${colors.surface1.hex};
      @define-color surface0 ${colors.surface0.hex};
      @define-color base ${colors.base.hex};
      @define-color mantle ${colors.mantle.hex};
      @define-color crust ${colors.crust.hex};

      * {
        border: none;
        min-height: 0;
        font-family: "Space Mono Nerd Font";
        font-weight: bold;
        font-size: 14px;
        padding: 0;
      }

      window#waybar {
        background: @base;
        border: 1px solid @mauve;
        border-radius: 7px;
      }

      tooltip {
        background-color: #353146;
        border: 1px solid @mauve;
        border-radius: 7px;
        font-size: 2px;
      }

      tooltip label {
        margin: 8px;
        color: @mauve;
      }

      #clock,
      #tray,
      #cpu,
      #memory,
      #battery,
      #network,
      #pulseaudio,
      #language {
        margin: 6px 6px 6px 0px;
        padding: 2px 8px;
      }

      #workspaces {
        margin: 6px 0px 6px 6px;
        border-radius: 7px;
      }

      #workspaces button {
        all: initial;
        min-width: 0;
        box-shadow: inset 0 -3px transparent;
        padding: 2px 4px;
        color: @text;
        background-color: @base;
        border: 1px solid @sapphire;
        border-radius: 7px;
        margin: 2px;
      }

      #workspaces button.active {
        color: @mantle;
        background-color: @red;
      }

      #workspaces button.urgent {
        background-color: @base;
        color: #1f1c27;
        border: 1px solid #e542c0;
        border-radius: 7px;
      }

      #clock {
        background-color: @base;
        border: 1px solid @mauve;
        border-radius: 7px;
        color: @text;
      }

      #cpu {
        background-color: @base;
        border: 1px solid @red;
        border-radius: 7px;
        color: @text;
      }

      #memory {
        background-color: @base;
        border: 1px solid @peach;
        border-radius: 7px;
        color: @text;
      }

      #network {
        background-color: @base;
        border: 1px solid @yellow;
        border-radius: 7px;
        color: @text;
        min-width: 100px;
      }

      #pulseaudio {
        background-color: @base;
        border: 1px solid @green;
        border-radius: 7px;
        color: @text;
        min-width: 60px;
      }

      #battery {
        background-color: @base;
        border: 1px solid @sapphire;
        border-radius: 7px;
        color: @text;
        min-width: 60px;
      }

      #tray {
        background-color: @base;
        border: 1px solid @mauve;
        border-radius: 7px;
        color: @text;
      }

      #cpu,
      #memory {
        min-width: 60px;
      }

      #cpu.critical,
      #memory.critical {
        color: #e542c0;
        border: 2px solid #e542c0;
        border-radius: 7px;
      }

      #battery.warning {
        color: @yellow;
        border: 3px solid @yellow;
        border-radius: 7px;
      }

      #battery.critical {
        color: @red;
        border: 3px solid @red;
        border-radius: 7px;
      }

      #battery.charging {
        color: @green;
        border: 3px solid @green;
        border-radius: 7px;
      }
    '';
  };
}
