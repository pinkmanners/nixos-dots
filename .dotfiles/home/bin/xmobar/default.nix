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
      , template = " %XMonadWorkspaces% }{ %cpu% | %memory% | %dynnetwork% | %default:Master% | %battery% | %trayerpad%%date% "

      -- Plugins
      , commands =
          [
            -- Workspaces from LeftWM
            Run XMonadLog

            -- CPU usage
            Run Cpu
              [ "-t", "cpu <total>%"
              , "-L", "50"
              , "-H", "90"
              , "--low", "#a6da95"
              , "--normal", "#eed49f"
              , "--high", "#ed8796"
              ] 20

            -- Memory usage
            Run Memory
              [ "-t", "mem <usedratio>%"
              , "-L", "50"
              , "-H", "80"
              , "--low", "#a6da95"
              , "--normal", "#eed49f"
              , "--high", "#ed8796"
              ] 20

            -- Network
            Run DynNetwork
              [ "-t", "net <rx>KB"
              , "-L", "1000"
              , "-H", "5000"
              , "--low", "#a6da95"
              , "--normal", "#eed49f"
              , "--high", "#ed8796"
              ] 20

            -- Volume
            Run Volume "default" "Master"
              [ "-t", "vol <volume>%"
              , "--"
              , "-O", ""
              , "-o", ""
              , "-c", "#7dc4e4"
              , "-C", "#7dc4e4"
              ] 10

            -- Battery
            Run BatteryP ["BAT0"]
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

            -- System tray padding (for stalonetray)
            Run Com "echo" ["      "] "trayerpad" 3600

            -- Date and time
            Run Date "%H:%M - %a, %d %b %Y" "date" 10
          ]
      }
  '';

  # XMonad Log configuration for workspace display
  home.file.".config/xmobar/xmonad.hs".text = ''
    import XMonad
    import XMonad.Hooks.DynamicLog
    import XMonad.Hooks.StatusBar
    import XMonad.Hooks.StatusBar.PP

    main :: IO ()
    main = xmonad . withEasySB (statusBarProp "xmobar" (pure myXmobarPP)) defToggleStrutsKey $ def
      { terminal = "kitty"
      , modMask = mod4Mask  -- Super key
      }

    myXmobarPP :: PP
    myXmobarPP = def
      { ppSep = " | "
      , ppCurrent = xmobarColor "#ed8796" "" . wrap "[" "]"
      , ppVisible = xmobarColor "#7dc4e4" ""
      , ppHidden = xmobarColor "#cad3f5" ""
      , ppHiddenNoWindows = xmobarColor "#5b6078" ""
      , ppTitle = xmobarColor "#a6da95" "" . shorten 50
      , ppLayout = xmobarColor "#eed49f" ""
      , ppUrgent = xmobarColor "#ee99a0" "" . wrap "!" "!"
      }
  '';

  # Stalonetray for system tray
  home.file.".config/stalonetray/stalonetrayrc".text = ''
    decorations none
    transparent false
    dockapp_mode none
    geometry 5x1-10+5
    background "#24273a"
    kludges force_icons_size
    grow_gravity NE
    icon_gravity NE
    icon_size 16
    sticky true
    window_strut auto
    window_type dock
    window_layer bottom
    no_shrink false
    skip_taskbar true
  '';
}
