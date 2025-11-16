# Xmobar Configuration
# Status bar for X11 with LeftWM
# Replicates Waybar layout and Catppuccin Macchiato theme

{ config, pkgs, lib, hostname, ... }:

{
  home.file.".config/xmobar/xmobarrc".text = ''
    Config {
      -- Appearance
      font = "SpaceMono Nerd Font Mono 10"
      , bgColor = "#24273a"
      , fgColor = "#cad3f5"
      , position = TopSize C 100 32
      , border = BottomB
      , borderColor = "#363a4f"

      -- Layout
      , sepChar = "%"
      , alignSep = "}{"
      , template = " %StdinReader% }{ %cpu% | %memory% | %dynnetwork% | %alsa:default:Master% | %battery% | %date% "

      -- Plugins
      , commands =
          [
            -- Workspaces from LeftWM
            Run StdinReader

            -- CPU usage
            , Run Cpu
              [ "-t", "cpu <total>%"
              , "-L", "50"
              , "-H", "90"
              , "--low", "#a6da95"
              , "--normal", "#eed49f"
              , "--high", "#ed8796"
              ] 20

            -- Memory usage
            , Run Memory
              [ "-t", "mem <usedratio>%"
              , "-L", "50"
              , "-H", "80"
              , "--low", "#a6da95"
              , "--normal", "#eed49f"
              , "--high", "#ed8796"
              ] 20

            -- Network
            , Run DynNetwork
              [ "-t", "net <rx>KB"
              , "-L", "1000"
              , "-H", "5000"
              , "--low", "#a6da95"
              , "--normal", "#eed49f"
              , "--high", "#ed8796"
              ] 20

            -- Volume
            , Run Alsa "default" "Master"
              [ "-t", "vol <volume>%"
              , "--"
              , "-O", ""
              , "-o", ""
              , "-c", "#7dc4e4"
              , "-C", "#7dc4e4"
              ]

            -- Battery
            , Run BatteryP ["BAT0"]
              [ "-t", "bat <left>%"
              , "-L", "20"
              , "-H", "80"
              , "--low", "#ed8796"
              , "--normal", "#eed49f"
              , "--high", "#a6da95"
              , "--"
              , "-O", ""
              , "-i", ""
              , "-o", ""
              ] 50

            -- Date and time
            , Run Date "%H:%M - %a, %d %b %Y" "date" 10
          ]
      }
  '';

  # Install xmobar
  home.packages = with pkgs; [
    xmobar
    alsa-utils  # For volume control
  ];
}
