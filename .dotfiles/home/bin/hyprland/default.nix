# Hyprland Configuration
# Wayland compositor with dynamic tiling
# Migrated from Fedora dots with updated dependencies

{ config, pkgs, lib, hostname, ... }:

{
  home.file = {
    # Main Hyprland config
    ".config/hypr/hyprland.conf".text = ''
      # Hyprland Configuration
      # Catppuccin Macchiato Theme

      source = ~/.config/hypr/monitors.conf
      source = ~/.config/hypr/defaultPrograms.conf
      source = ~/.config/hypr/autoStart.conf
      source = ~/.config/hypr/environmentVariables.conf
      source = ~/.config/hypr/permissions.conf
      source = ~/.config/hypr/variables.conf
      source = ~/.config/hypr/keybindings.conf
      source = ~/.config/hypr/workspacesWindows.conf
      source = ~/.config/hypr/macchiato.conf
    '';

    # Monitor configuration
    ".config/hypr/monitors.conf".text =
      if hostname == "L14" then ''
        # L14 Monitor Configuration
        # Internal display + potential external monitors

        monitor=eDP-1,1920x1080@60,0x0,1
        monitor=,preferred,auto,1
      ''
      else if hostname == "T450" then ''
        # T450 Monitor Configuration
        # Internal 1600x900 display with room for expansion

        monitor=eDP-1,1600x900@60,0x0,1
        monitor=,preferred,auto,1
      ''
      else ''
        # Default monitor configuration
        monitor=,preferred,auto,1
      '';

    # Default programs
    ".config/hypr/defaultPrograms.conf".text = ''
      # Default Programs

      $terminal = kitty
      $menu = rmenu -r drun
      $webBrowser = brave
      $fileManager = thunar
      $powermenu = rmenu -r powermenu
    '';

    # Autostart applications
    ".config/hypr/autoStart.conf".text = ''
      # Autostart Applications

      # Wallpaper
      exec-once = hyprpaper

      # Status bar
      exec-once = ashell

      # Notification daemon
      exec-once = moxnotify

      # Polkit agent
      exec-once = ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1

      # Network manager applet
      exec-once = nm-applet

      # Automounting
      exec-once = udiskie --tray

      # GNOME Keyring
      exec-once = gnome-keyring-daemon --start --components=pkcs11,secrets,ssh

      # Clipboard manager
      exec-once = wl-paste --type text --watch cliphist store
      exec-once = wl-paste --type image --watch cliphist store

      # Idle and lock
      exec-once = hypridle

      # XDG Portal
      exec-once = dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
    '';

    # Environment variables
    ".config/hypr/environmentVariables.conf".text = ''
      # Environment Variables

      # GTK theme
      env = GTK_THEME,Catppuccin-Macchiato-Standard-Mauve-Dark

      # Cursor settings for Wayland/Hyprland
      env = HYPRCURSOR_THEME,Mocu-White-Right-H
      env = HYPRCURSOR_SIZE,32

      # Cursor settings for X11/XWayland (use white to match Hyprland)
      env = XCURSOR_THEME,Mocu-White-Right-X
      env = XCURSOR_SIZE,32

      # Hyprshot location
      env = HYPRSHOT_DIR,$HOME/Pictures/Screenshots

      # Toolkit backends
      env = GDK_BACKEND,wayland,x11,*
      env = SDL_VIDEODRIVER,wayland

      # Qt variables
      env = QT_AUTO_SCREEN_SCALE_FACTOR,0
      env = QT_QPA_PLATFORM,wayland;xcb
      env = QT_WAYLAND_DISABLE_WINDOWDECORATION,1

      env = ELECTRON_OZONE_PLATFORM_HINT,wayland
    '';

    # Permissions
    ".config/hypr/permissions.conf".text = ''
      # Permissions and XWayland

      xwayland {
        force_zero_scaling = true
      }
    '';

    # Variables (general settings, input, decoration, animations)
    ".config/hypr/variables.conf".text = ''
      # Hyprland Variables

      # General settings
      general {
        gaps_in = 2.5
        gaps_out = 5
        border_size = 1

        col.active_border = rgb(ed8796)
        col.inactive_border = rgb(7dc4e4)

        resize_on_border = false
        allow_tearing = false

        layout = dwindle
      }

      # Input settings
      input {
        kb_layout = us
        kb_variant =
        kb_model =
        kb_options =
        kb_rules =

        follow_mouse = 1
        sensitivity = 0

        natural_scroll = true
        touchpad {
          natural_scroll = true
        }
      }

      # Gestures
      gestures {
        workspace_swipe = true
        workspace_swipe_fingers = 3
      }

      # Decoration
      decoration {
        rounding = 7

        active_opacity = 1.0
        inactive_opacity = 0.8

        shadow {
          enabled = true
          range = 4
          render_power = 3
          color = rgba(1a1a1aee)
        }

        blur {
          enabled = true
          size = 3
          passes = 1
          vibrancy = 0.1696
        }
      }

      # Animations
      animations {
        enabled = true
        bezier = myBezier, 0.05, 0.9, 0.1, 1.05

        animation = windows, 1, 7, myBezier
        animation = windowsOut, 1, 7, default, popin 80%
        animation = border, 1, 10, default
        animation = borderangle, 1, 8, default
        animation = fade, 1, 7, default
        animation = workspaces, 1, 6, default
      }

      # Dwindle layout
      dwindle {
        pseudotile = true
        preserve_split = true
      }

      # Master layout
      master {
        new_status = master
      }

      # Misc
      misc {
        force_default_wallpaper = 0
        disable_hyprland_logo = true
      }
    '';

    # Keybindings
    ".config/hypr/keybindings.conf".text = ''
      # Keybindings

      $mainMod = SUPER

      # ===== APPLICATION LAUNCHING =====
      bind = $mainMod, Return, exec, $terminal
      bind = $mainMod, R, exec, $menu
      bind = $mainMod, SPACE, exec, $menu
      bind = $mainMod, W, exec, $webBrowser
      bind = $mainMod, E, exec, $fileManager
      bind = $mainMod, T, exec, telegram-desktop
      bind = $mainMod, P, exec, logseq
      bind = $mainMod, Z, exec, zed

      # Close window
      bind = $mainMod, Q, killactive,

      # Lock screen
      bind = $mainMod, L, exec, hyprlock

      # Power menu
      bind = $mainMod SHIFT, E, exec, $powermenu

      # Screenshot
      bind = $mainMod SHIFT, S, exec, hyprshot -m region

      # ===== WINDOW MANAGEMENT =====
      # Move focus
      bind = $mainMod, K, movefocus, u
      bind = $mainMod, J, movefocus, d
      bind = $mainMod, H, movefocus, l
      bind = $mainMod, L, movefocus, r

      # Move windows
      bind = $mainMod SHIFT, K, movewindow, u
      bind = $mainMod SHIFT, J, movewindow, d
      bind = $mainMod SHIFT, H, movewindow, l
      bind = $mainMod SHIFT, L, movewindow, r

      # Toggle floating
      bind = $mainMod, V, togglefloating,

      # Toggle fullscreen
      bind = $mainMod, F, fullscreen,

      # Toggle pseudo-tiling
      bind = $mainMod, P, pseudo,

      # Toggle split
      bind = $mainMod, S, togglesplit,

      # ===== WORKSPACE MANAGEMENT =====
      # Switch to workspace
      bind = $mainMod, 1, workspace, 1
      bind = $mainMod, 2, workspace, 2
      bind = $mainMod, 3, workspace, 3
      bind = $mainMod, 4, workspace, 4
      bind = $mainMod, 5, workspace, 5
      bind = $mainMod, 6, workspace, 6
      bind = $mainMod, 7, workspace, 7
      bind = $mainMod, 8, workspace, 8
      bind = $mainMod, 9, workspace, 9

      # Move window to workspace
      bind = $mainMod SHIFT, 1, movetoworkspace, 1
      bind = $mainMod SHIFT, 2, movetoworkspace, 2
      bind = $mainMod SHIFT, 3, movetoworkspace, 3
      bind = $mainMod SHIFT, 4, movetoworkspace, 4
      bind = $mainMod SHIFT, 5, movetoworkspace, 5
      bind = $mainMod SHIFT, 6, movetoworkspace, 6
      bind = $mainMod SHIFT, 7, movetoworkspace, 7
      bind = $mainMod SHIFT, 8, movetoworkspace, 8
      bind = $mainMod SHIFT, 9, movetoworkspace, 9

      # Scroll through workspaces
      bind = $mainMod, mouse_down, workspace, e+1
      bind = $mainMod, mouse_up, workspace, e-1

      # Mouse bindings
      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow

      # Clipboard history
      bind = $mainMod, V, exec, cliphist list | rmenu -f dmenu | cliphist decode | wl-copy

      # Brightness control (using light)
      bind = , XF86MonBrightnessUp, exec, light -A 5
      bind = , XF86MonBrightnessDown, exec, light -U 5

      # Volume control
      bind = , XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
      bind = , XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
      bind = , XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    '';

    # Workspace and window rules
    ".config/hypr/workspacesWindows.conf".text = ''
      # Workspace Rules

      # Window rules
      windowrule = float, ^(pavucontrol)$
      windowrule = float, ^(nm-connection-editor)$
      windowrule = float, ^(blueman-manager)$

      # Workspace rules
      workspace = 1, default:true
    '';

    # Catppuccin Macchiato colors
    ".config/hypr/macchiato.conf".text = ''
      # Catppuccin Macchiato Color Scheme

      $rosewater = rgb(f4dbd6)
      $flamingo = rgb(f0c6c6)
      $pink = rgb(f5bde6)
      $mauve = rgb(c6a0f6)
      $red = rgb(ed8796)
      $maroon = rgb(ee99a0)
      $peach = rgb(f5a97f)
      $yellow = rgb(eed49f)
      $green = rgb(a6da95)
      $teal = rgb(8bd5ca)
      $sky = rgb(91d7e3)
      $sapphire = rgb(7dc4e4)
      $blue = rgb(8aadf4)
      $lavender = rgb(b7bdf8)
      $text = rgb(cad3f5)
      $subtext1 = rgb(b8c0e0)
      $subtext0 = rgb(a5adcb)
      $overlay2 = rgb(939ab7)
      $overlay1 = rgb(8087a2)
      $overlay0 = rgb(6e738d)
      $surface2 = rgb(5b6078)
      $surface1 = rgb(494d64)
      $surface0 = rgb(363a4f)
      $base = rgb(24273a)
      $mantle = rgb(1e2030)
      $crust = rgb(181926)

      # Alpha variants
      $rosewaterAlpha = f4dbd6
      $flamingoAlpha = f0c6c6
      $pinkAlpha = f5bde6
      $mauveAlpha = c6a0f6
      $redAlpha = ed8796
      $maroonAlpha = ee99a0
      $peachAlpha = f5a97f
      $yellowAlpha = eed49f
      $greenAlpha = a6da95
      $tealAlpha = 8bd5ca
      $skyAlpha = 91d7e3
      $sapphireAlpha = 7dc4e4
      $blueAlpha = 8aadf4
      $lavenderAlpha = b7bdf8
      $textAlpha = cad3f5
      $subtext1Alpha = b8c0e0
      $subtext0Alpha = a5adcb
      $overlay2Alpha = 939ab7
      $overlay1Alpha = 8087a2
      $overlay0Alpha = 6e738d
      $surface2Alpha = 5b6078
      $surface1Alpha = 494d64
      $surface0Alpha = 363a4f
      $baseAlpha = 24273a
      $mantleAlpha = 1e2030
      $crustAlpha = 181926
    '';

    # Hyprlock configuration
    ".config/hypr/hyprlock.conf".text = ''
      source = $HOME/.config/hypr/macchiato.conf

      $accent = $mauve
      $accentAlpha = $mauveAlpha
      $font = SpaceMono Nerd Font

      # GENERAL
      general {
        disable_loading_bar = true
        hide_cursor = true
        grace = 0
        no_fade_in = false
      }

      # BACKGROUND
      background {
        monitor =
        path = $HOME/.dotfiles/home/share/wallpapers/mio1.png
        blur_passes = 2
        blur_size = 7
        noise = 0.0117
        contrast = 0.8916
        brightness = 0.8172
        vibrancy = 0.1696
        vibrancy_darkness = 0.0
      }

      # TIME
      label {
        monitor =
        text = $TIME
        color = $text
        font_size = 90
        font_family = $font
        position = -30, 0
        halign = right
        valign = top
      }

      # DATE
      label {
        monitor =
        text = cmd[update:43200000] date +"%A, %d %B %Y"
        color = $text
        font_size = 25
        font_family = $font
        position = -30, -150
        halign = right
        valign = top
      }

      # USER AVATAR
      image {
        monitor =
        path = $HOME/.face
        size = 100
        border_color = $accent
        position = 0, 75
        halign = center
        valign = center
      }

      # INPUT FIELD
      input-field {
        monitor =
        size = 350, 60
        outline_thickness = 4
        dots_size = 0.2
        dots_spacing = 0.2
        dots_center = true
        outer_color = $accent
        inner_color = $surface0
        font_color = $text
        fade_on_empty = false
        placeholder_text = <span foreground="##$textAlpha"><i>󰌾 Logged in as </i><span foreground="##$accentAlpha">$USER</span></span>
        hide_input = false
        check_color = $accent
        fail_color = $red
        fail_text = <i>$FAIL <b>($ATTEMPTS)</b></i>
        font_family = $font
        capslock_color = $yellow
        position = 0, -47
        halign = center
        valign = center
      }
    '';

    # Hypridle configuration
    ".config/hypr/hypridle.conf".text = ''
      general {
        lock_cmd = pidof hyprlock || hyprlock       # avoid starting multiple hyprlock instances.
        before_sleep_cmd = loginctl lock-session    # lock before suspend.
        after_sleep_cmd = hyprctl dispatch dpms on  # to avoid having to press a key twice to turn on the display.
      }

      listener {
        timeout = 300                                # 5min
        on-timeout = light -O && light -S 10         # set monitor backlight to minimum, avoid 0 on OLED monitor.
        on-resume = light -I                         # monitor backlight restore.
      }

      listener {
        timeout = 420                                 # 7min
        on-timeout = loginctl lock-session            # lock screen when timeout has passed
      }

      listener {
        timeout = 510                                                     # 8.5min
        on-timeout = hyprctl dispatch dpms off                            # screen off when timeout has passed
        on-resume = hyprctl dispatch dpms on && light -I                  # screen on when activity is detected after timeout has fired.
      }

      listener {
        timeout = 600                                 # 10min
        on-timeout = systemctl suspend                # suspend pc
      }

      listener {
        timeout = 610                                 # just after suspend point to ensure brightness is restored
        on-timeout = light -I
      }
    '';

    # Hyprpaper configuration
    ".config/hypr/hyprpaper.conf".text = ''
      preload = ~/.dotfiles/home/share/wallpapers/mio1.png
      wallpaper = ,~/.dotfiles/home/share/wallpapers/mio1.png
      splash = false
    '';
  };

  # Install Hyprland dependencies
  home.packages = with pkgs; [
    hyprland
    hyprpaper
    hyprpicker
    hypridle
    hyprlock
    hyprshot
    xdg-desktop-portal-hyprland
  ];
}
