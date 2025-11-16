# LeftWM Configuration
# Rust-based tiling window manager for X11
# Based on Hyprland configuration with similar keybindings and layout

{ config, pkgs, lib, hostname, ... }:

{
  # LeftWM is managed through home-manager
  home.file = {
    # Main LeftWM config
    ".config/leftwm/config.ron".text = ''
      #![enable(implicit_some)]
      (
          modkey: "Mod4",
          mousekey: "Mod4",
          workspaces: [],
          tags: [
              "1",
              "2",
              "3",
              "4",
              "5",
              "6",
              "7",
              "8",
              "9",
          ],
          max_window_width: None,
          layouts: [
              Dwindle,
          ],
          layout_mode: Tag,
          insert_behavior: Bottom,
          scratchpad: [
              (name: "Alacritty", value: "alacritty", x: 860, y: 390, height: 300, width: 200),
          ],
          window_rules: [],
          disable_current_tag_swap: false,
          disable_tile_drag: false,
          disable_window_snap: true,
          focus_behaviour: Sloppy,
          focus_new_windows: true,
          sloppy_mouse_follows_focus: true,
          keybind: [
              // ===== APPLICATION LAUNCHING =====
              (command: Execute, value: "kitty", modifier: ["modkey"], key: "Return"),
              (command: Execute, value: "rmenu -r drun", modifier: ["modkey"], key: "r"),
              (command: Execute, value: "rmenu -r drun", modifier: ["modkey"], key: "space"),
              (command: Execute, value: "brave", modifier: ["modkey"], key: "w"),
              (command: Execute, value: "thunar", modifier: ["modkey"], key: "e"),
              (command: Execute, value: "telegram-desktop", modifier: ["modkey"], key: "t"),
              (command: Execute, value: "logseq", modifier: ["modkey"], key: "p"),
              (command: Execute, value: "zed", modifier: ["modkey"], key: "z"),

              // Close window
              (command: CloseWindow, value: "", modifier: ["modkey"], key: "q"),

              // Lock screen
              (command: Execute, value: "i3lock-color -c 24273a", modifier: ["modkey"], key: "l"),

              // Power menu
              (command: Execute, value: "rmenu -r powermenu", modifier: ["modkey", "Shift"], key: "e"),

              // ===== WINDOW MANAGEMENT =====
              // Move focus
              (command: FocusWindowUp, value: "", modifier: ["modkey"], key: "k"),
              (command: FocusWindowDown, value: "", modifier: ["modkey"], key: "j"),
              (command: FocusWindowLeft, value: "", modifier: ["modkey"], key: "h"),
              (command: FocusWindowRight, value: "", modifier: ["modkey"], key: "l"),

              // Move windows
              (command: MoveWindowUp, value: "", modifier: ["modkey", "Shift"], key: "k"),
              (command: MoveWindowDown, value: "", modifier: ["modkey", "Shift"], key: "j"),
              (command: MoveWindowLeft, value: "", modifier: ["modkey", "Shift"], key: "h"),
              (command: MoveWindowRight, value: "", modifier: ["modkey", "Shift"], key: "l"),

              // Toggle floating
              (command: ToggleFloating, value: "", modifier: ["modkey"], key: "v"),

              // Toggle fullscreen
              (command: ToggleFullScreen, value: "", modifier: ["modkey"], key: "f"),

              // ===== WORKSPACE MANAGEMENT =====
              // Switch to workspace
              (command: GoToTag, value: "1", modifier: ["modkey"], key: "1"),
              (command: GoToTag, value: "2", modifier: ["modkey"], key: "2"),
              (command: GoToTag, value: "3", modifier: ["modkey"], key: "3"),
              (command: GoToTag, value: "4", modifier: ["modkey"], key: "4"),
              (command: GoToTag, value: "5", modifier: ["modkey"], key: "5"),
              (command: GoToTag, value: "6", modifier: ["modkey"], key: "6"),
              (command: GoToTag, value: "7", modifier: ["modkey"], key: "7"),
              (command: GoToTag, value: "8", modifier: ["modkey"], key: "8"),
              (command: GoToTag, value: "9", modifier: ["modkey"], key: "9"),

              // Move window to workspace
              (command: MoveToTag, value: "1", modifier: ["modkey", "Shift"], key: "1"),
              (command: MoveToTag, value: "2", modifier: ["modkey", "Shift"], key: "2"),
              (command: MoveToTag, value: "3", modifier: ["modkey", "Shift"], key: "3"),
              (command: MoveToTag, value: "4", modifier: ["modkey", "Shift"], key: "4"),
              (command: MoveToTag, value: "5", modifier: ["modkey", "Shift"], key: "5"),
              (command: MoveToTag, value: "6", modifier: ["modkey", "Shift"], key: "6"),
              (command: MoveToTag, value: "7", modifier: ["modkey", "Shift"], key: "7"),
              (command: MoveToTag, value: "8", modifier: ["modkey", "Shift"], key: "8"),
              (command: MoveToTag, value: "9", modifier: ["modkey", "Shift"], key: "9"),

              // ===== LEFTWM CONTROLS =====
              // Reload LeftWM
              (command: SoftReload, value: "", modifier: ["modkey", "Shift"], key: "r"),

              // Quit LeftWM
              (command: Execute, value: "loginctl kill-session $XDG_SESSION_ID", modifier: ["modkey", "Shift"], key: "q"),
          ],
      )
    '';

    # LeftWM theme configuration
    ".config/leftwm/themes/catppuccin-macchiato/theme.ron".text = ''
      (
          border_width: 1,
          margin: 5,
          default_border_color: "#7dc4e4",
          floating_border_color: "#7dc4e4",
          focused_border_color: "#ed8796",
      )
    '';

    # LeftWM up script (runs on startup)
    ".config/leftwm/themes/catppuccin-macchiato/up".text = ''
      #!/usr/bin/env bash

      # Kill any existing processes
      pkill -f xmobar
      pkill -f wired

      # Set wallpaper with feh
      feh --bg-scale ~/.dotfiles/home/share/wallpapers/mio2.png &

      # Start xmobar status bar
      xmobar ~/.config/xmobar/xmobarrc &

      # Start wired notification daemon
      wired &

      # Start network manager applet
      nm-applet &

      # Start udiskie for automounting
      udiskie --tray &

      # Set cursor theme
      xsetroot -cursor_name left_ptr &

      # Screen brightness control (light)
      light -N 1 &

      # Polkit agent
      ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1 &

      # GNOME Keyring
      eval $(gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
      export SSH_AUTH_SOCK
    '';

    # LeftWM down script (runs on shutdown)
    ".config/leftwm/themes/catppuccin-macchiato/down".text = ''
      #!/usr/bin/env bash

      pkill -f xmobar
      pkill -f wired
      pkill -f nm-applet
      pkill -f udiskie
      pkill -f polkit-gnome-authentication-agent-1
    '';
  };

  # Make scripts executable
  home.activation.makeLeftwmScriptsExecutable = lib.hm.dag.entryAfter ["writeBoundary"] ''
    chmod +x ~/.config/leftwm/themes/catppuccin-macchiato/up
    chmod +x ~/.config/leftwm/themes/catppuccin-macchiato/down
  '';

  # Install dependencies
  home.packages = with pkgs; [
    leftwm
    feh          # Wallpaper setter
    i3lock-color # Lock screen
  ];
}
