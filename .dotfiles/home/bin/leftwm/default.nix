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
              (command: Execute, value: "i3lock -c 24273a", modifier: ["modkey"], key: "l"),

              // Power menu
              (command: Execute, value: "rmenu -r powermenu", modifier: ["modkey", "Control"], key: "Delete"),

              // ===== SCREENSHOTS =====
              (command: Execute, value: "scrot '%Y-%m-%d_$wx$h.png' -e 'mv $f ~/Pictures/Screenshots/'", modifier: [], key: "Print"),
              (command: Execute, value: "scrot -u '%Y-%m-%d_$wx$h.png' -e 'mv $f ~/Pictures/Screenshots/'", modifier: ["modkey"], key: "Print"),
              (command: Execute, value: "scrot -s '%Y-%m-%d_$wx$h.png' -e 'mv $f ~/Pictures/Screenshots/'", modifier: ["modkey", "Shift"], key: "Print"),

              // ===== WINDOW MANAGEMENT =====
              (command: ToggleFloating, value: "", modifier: ["modkey"], key: "comma"),
              (command: ToggleScratchPad, value: "Alacritty", modifier: ["modkey"], key: "grave"),

              // Focus windows
              (command: FocusWindowUp, value: "", modifier: ["modkey"], key: "k"),
              (command: FocusWindowDown, value: "", modifier: ["modkey"], key: "j"),
              (command: FocusWindowUp, value: "", modifier: ["modkey"], key: "Up"),
              (command: FocusWindowDown, value: "", modifier: ["modkey"], key: "Down"),

              // Move windows
              (command: MoveWindowUp, value: "", modifier: ["modkey", "Shift"], key: "k"),
              (command: MoveWindowDown, value: "", modifier: ["modkey", "Shift"], key: "j"),
              (command: MoveWindowTop, value: "", modifier: ["modkey", "Shift"], key: "Return"),
              (command: MoveWindowUp, value: "", modifier: ["modkey", "Shift"], key: "Up"),
              (command: MoveWindowDown, value: "", modifier: ["modkey", "Shift"], key: "Down"),

              // Resize windows
              (command: IncreaseMainWidth, value: "5", modifier: ["modkey", "Control"], key: "l"),
              (command: DecreaseMainWidth, value: "5", modifier: ["modkey", "Control"], key: "h"),
              (command: IncreaseMainWidth, value: "5", modifier: ["modkey", "Control"], key: "Right"),
              (command: DecreaseMainWidth, value: "5", modifier: ["modkey", "Control"], key: "Left"),

              // ===== WORKSPACE/TAG MANAGEMENT =====
              (command: GotoTag, value: "1", modifier: ["modkey"], key: "1"),
              (command: GotoTag, value: "2", modifier: ["modkey"], key: "2"),
              (command: GotoTag, value: "3", modifier: ["modkey"], key: "3"),
              (command: GotoTag, value: "4", modifier: ["modkey"], key: "4"),
              (command: GotoTag, value: "5", modifier: ["modkey"], key: "5"),
              (command: GotoTag, value: "6", modifier: ["modkey"], key: "6"),
              (command: GotoTag, value: "7", modifier: ["modkey"], key: "7"),
              (command: GotoTag, value: "8", modifier: ["modkey"], key: "8"),
              (command: GotoTag, value: "9", modifier: ["modkey"], key: "9"),

              // Move window to tag
              (command: MoveToTag, value: "1", modifier: ["modkey", "Shift"], key: "1"),
              (command: MoveToTag, value: "2", modifier: ["modkey", "Shift"], key: "2"),
              (command: MoveToTag, value: "3", modifier: ["modkey", "Shift"], key: "3"),
              (command: MoveToTag, value: "4", modifier: ["modkey", "Shift"], key: "4"),
              (command: MoveToTag, value: "5", modifier: ["modkey", "Shift"], key: "5"),
              (command: MoveToTag, value: "6", modifier: ["modkey", "Shift"], key: "6"),
              (command: MoveToTag, value: "7", modifier: ["modkey", "Shift"], key: "7"),
              (command: MoveToTag, value: "8", modifier: ["modkey", "Shift"], key: "8"),
              (command: MoveToTag, value: "9", modifier: ["modkey", "Shift"], key: "9"),

              // ===== SYSTEM FUNCTIONS =====
              (command: SoftReload, value: "", modifier: ["modkey", "Shift"], key: "r"),
              (command: Execute, value: "loginctl kill-session $XDG_SESSION_ID", modifier: ["modkey", "Shift"], key: "e"),
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
      feh --bg-scale ~/dotfiles/home/share/wallpapers/mio2.png &

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
}
