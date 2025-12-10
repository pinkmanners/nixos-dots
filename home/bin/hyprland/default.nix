{ config, lib, pkgs, ... }:

let
  colors = (import ../../share/colors/catppuccin-macchiato/default.nix { inherit lib; }).colors.catppuccin;
  hostname = config.networking.hostName or "unknown";

  # Monitor configurations based on hostname
  monitorConfig =
    if hostname == "L14" then ''
      eDP-1, 1920x1080@60, 2500x2500, 1.2

      DP-4, 1920x1080@75, 580x2160, 1
      DP-5, 1920x1080@75, 580x2160, 1

      HDMI-A-1, 2560x1440@60, 0x1625, 1
    ''
    else if hostname == "T450" then ''
      eDP-1, 1600x900@60, 0x0, 1
    ''
    else ''
      , preferred, auto, 1
    '';

in {
  home.packages = with pkgs; [
    hyprland
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
    hyprpaper
    hyprlock
    hyprpicker
    hyprshot
    nwg-displays
    nwg-look
  ];

  home.sessionVariables = {
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "Hyprland";
    GTK_USE_PORTAL = "1";
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
    config = {
      hyprland = {
        default = [ "hyprland gtk" ];
      };
    };
    xdgOpenUsePortal = true;
  };


  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    xwayland.enable = true;

    settings = {
      # Monitor configuration
      monitor = lib.mkForce (lib.splitString "\n" (lib.removeSuffix "\n" monitorConfig));

      # Environment variables
      env = [
        "GTK_THEME,Catppuccin-Mauve-Dark-Macchiato"
        "XCURSOR_THEME,Mocu-White-Right-X"
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_THEME,Mocu-White-Right-H"
        "HYPRCURSOR_SIZE,24"
        "HYPRSHOT_DIR,$HOME/Pictures/Screenshots"
        "GDK_BACKEND,wayland,x11,*"
        "SDL_VIDEODRIVER,wayland"
        "QT_AUTO_SCREEN_SCALE_FACTOR,0"
        "QT_QPA_PLATFORM,wayland;xcb"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        "ELECTRON_OZONE_PLATFORM_HINT,wayland"
      ];

      # Variables
      "$mainMod" = "SUPER";
      "$menu" = "rofi -show drun";
      "$powermenu" = ".local/bin/rofi-powermenu";
      "$terminal" = "alacritty";
      "$fileManager" = "thunar";
      "$webBrowser" = "brave";

      # General settings
      general = {
        gaps_in = 2.5;
        gaps_out = 5;
        border_size = 1;
        "col.active_border" = "rgb(${colors.red.rgb})";
        "col.inactive_border" = "rgb(${colors.sapphire.rgb})";
        resize_on_border = false;
        allow_tearing = false;
        layout = "dwindle";
      };

      # Input settings
      input = {
        kb_layout = "us";
        follow_mouse = 1;
        sensitivity = 0;
        natural_scroll = true;
        touchpad = {
          natural_scroll = true;
        };
      };

      # Gestures
      #gestures = {
      #  workspace_swipe = true;
      #  workspace_swipe_fingers = 3;
      #};

      # Decoration
      decoration = {
        rounding = 7;
        active_opacity = 1.0;
        inactive_opacity = 0.88;

        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };

        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };
      };

      # Animations
      animations = {
        enabled = true;

        bezier = [
          "easeOutQuint, 0.23, 1, 0.32, 1"
          "easeInOutCubic, 0.65, 0.05, 0.36, 1"
          "linear, 0, 0, 1, 1"
          "almostLinear, 0.5, 0.5, 0.75, 1"
          "quick, 0.15, 0, 0.1, 1"
        ];

        animation = [
          "global, 1, 10, default"
          "border, 1, 5.39, easeOutQuint"
          "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.49, linear, popin 87%"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"
          "layers, 1, 3.81, easeOutQuint"
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
          "workspaces, 1, 1.94, almostLinear, fade"
          "workspacesIn, 1, 1.21, almostLinear, fade"
          "workspacesOut, 1, 1.94, almostLinear, fade"
          "zoomFactor, 1, 7, quick"
        ];
      };

      # Dwindle layout
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      # Master layout
      master = {
        new_status = "master";
      };

      # Misc
      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
      };

      # Window rules
      windowrule = [
        "suppressevent maximize, class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
      ];

      # Keybindings
      bind = [
        # Launching programs, except for the first one ^_^

        "$mainMod, Q, killactive,"

        "$mainMod, space, exec, $menu"
        "$mainMod, Return, exec, $terminal"

        "$mainMod, W, exec, $webBrowser"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, R, exec, $menu"
        "$mainMod, T, exec, Telegram"
        "$mainMod, p, exec, logseq"
        "CONTROL ALT, P, exec, hyprpicker -a"

        "$mainMod, L, exec, hyprlock"

        "$mainMod, Z, exec, zeditor"

        # Screenshots
        ", PRINT, exec, ${pkgs.hyprshot}/bin/hyprshot -m output --freeze"
        "$mainMod, PRINT, exec, ${pkgs.hyprshot}/bin/hyprshot -m window --freeze"
        "$mainMod SHIFT, PRINT, exec, ${pkgs.hyprshot}/bin/hyprshot -m region --freeze"

        # System functions
        "CONTROL ALT, Delete, exec, $powermenu"

        # Window options
        "$mainMod, slash, togglesplit,"
        "$mainMod, period, pseudo,"
        "$mainMod, comma, togglefloating,"

        # Move focus with mainMod + arrow keys
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        # Move windows with mainMod + shift + hjkl
        "$mainMod SHIFT, h, movewindow, l"
        "$mainMod SHIFT, j, movewindow, d"
        "$mainMod SHIFT, k, movewindow, u"
        "$mainMod SHIFT, l, movewindow, r"

        # Reseize windows with control + alt + hjkl
        "CONTROL ALT, l, resizeactive, 50 0"
        "CONTROL ALT, h, resizeactive, -50 0"
        "CONTROL ALT, k, resizeactive, 0 -25"
        "CONTROL ALT, j, resizeactive, 0 25"

        # Switch workspaces with mainMod + [0-9]
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        # Scroll through existing workspaces with mainMod + scroll
        #"$mainMod, mouse_down, workspace, e+1"
        #"$mainMod, mouse_up, workspace, e-1"
      ];

      # Bind with lock
      bindl = [
        ",switch:off:Lid Switch, exec, hyprlock --immediate && systemctl suspend"
        ", XF86AudioNext, exec, ${pkgs.playerctl}/bin/playerctl next"
        ", XF86AudioPause, exec, ${pkgs.playerctl}/bin/playerctl play-pause"
        ", XF86AudioPlay, exec, ${pkgs.playerctl}/bin/playerctl play-pause"
        ", XF86AudioPrev, exec, ${pkgs.playerctl}/bin/playerctl previous"
      ];

      # Bind with repeat
      bindel = [
        ",XF86AudioRaiseVolume, exec, ${pkgs.wireplumber}/bin/wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, ${pkgs.brightnessctl}/bin/brightnessctl -e4 -n2 set 5%+"
        ",XF86MonBrightnessDown, exec, ${pkgs.brightnessctl}/bin/brightnessctl -e4 -n2 set 5%-"
      ];

      # Mouse bindings
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      # Exec-once
      exec-once = [
        ""
      ];
    };
  };

  # Hypridle service configuration
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };

      listener = [
        {
          timeout = 150;
          on-timeout = "${pkgs.brightnessctl}/bin/brightnessctl -s set 10";
          on-resume = "${pkgs.brightnessctl}/bin/brightnessctl -r";
        }
        {
          timeout = 300;
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 330;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on && ${pkgs.brightnessctl}/bin/brightnessctl -r";
        }
        {
          timeout = 480;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };

  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;

      preload = [ "~/.dotfiles/home/share/wallpapers/mio1.jpg" ];
      wallpaper = [ ",~/.dotfiles/home/share/wallpapers/mio1.jpg" ];
    };
  };

  # hyprlock configuration
  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        hide_cursor = true;
      };

      background = [
        {
          monitor = "";
          path = "$HOME/.config/background";
          blur_passes = 0;
          color = "rgb(${colors.base.rgb})";
        }
      ];

      label = [
        # Time
        {
          monitor = "";
          text = "$TIME";
          color = "rgb(${colors.text.rgb})";
          font_size = 90;
          font_family = "Space Mono Nerd Font";
          position = "-30, 0";
          halign = "right";
          valign = "top";
        }
        # Date
        {
          monitor = "";
          text = "cmd[update:43200000] date +\"%A, %d %B %Y\"";
          color = "rgb(${colors.text.rgb})";
          font_size = 25;
          font_family = "Space Mono Nerd Font";
          position = "-30, -150";
          halign = "right";
          valign = "top";
        }
        # Fingerprint
        {
          monitor = "";
          text = "$FPRINTPROMPT";
          color = "rgb(${colors.text.rgb})";
          font_size = 14;
          font_family = "Space Mono Nerd Font";
          position = "0, -107";
          halign = "center";
          valign = "center";
        }
      ];

      image = [
        # User avatar
        {
          monitor = "";
          path = "$HOME/.face";
          size = 100;
          border_color = "rgb(${colors.mauve.rgb})";
          position = "0, 75";
          halign = "center";
          valign = "center";
        }
      ];

      input-field = [
        {
          monitor = "";
          size = "350, 60";
          outline_thickness = 4;
          dots_size = 0.2;
          dots_spacing = 0.2;
          dots_center = true;
          outer_color = "rgb(${colors.mauve.rgb})";
          inner_color = "rgb(${colors.surface0.rgb})";
          font_color = "rgb(${colors.text.rgb})";
          fade_on_empty = false;
          placeholder_text = "<span foreground=\"##${colors.text.rgb}\"><i>󰌾 Logged in as </i><span foreground=\"##${colors.mauve.rgb}\">$USER</span></span>";
          hide_input = false;
          check_color = "rgb(${colors.mauve.rgb})";
          fail_color = "rgb(${colors.red.rgb})";
          fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
          font_family = "Space Mono Nerd Font";
          capslock_color = "rgb(${colors.yellow.rgb})";
          position = "0, -47";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
