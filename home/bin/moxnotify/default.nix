{ config, lib, pkgs, ... }:

let
  colors = (import ../../share/colors/catppuccin-macchiato/default.nix { inherit lib; }).colors.catppuccin;

  moxnotifyConfig = pkgs.writeText "moxnotify-config.lua" ''
    -- Moxnotify Configuration

    return {
      -- Notification position on screen
      position = {
        x = "right",  -- left, center, right
        y = "top",    -- top, center, bottom
      },

      -- Offset from screen edge (in pixels)
      offset = {
        x = 10,
        y = 10,
      },

      -- Notification dimensions
      width = 400,

      -- Spacing between notifications
      spacing = 10,

      -- Maximum number of notifications to show
      max_visible = 5,

      -- Default timeout in milliseconds (0 for no timeout)
      timeout = 5000,

      -- Notification styling
      style = {
        background = "${colors.mantle.hex}",
        border_color = "${colors.surface1.hex}",
        border_width = 2,
        border_radius = 12,
        padding = 15,

        -- Text styling
        text = {
          color = "${colors.text.hex}",
          font = "Space Mono Nerd Font 12",
        },

        -- Title styling
        title = {
          color = "${colors.text.hex}",
          font = "Space Mono Nerd Font Bold 14",
        },

        -- Close button styling
        close_button = {
          color = "${colors.red.hex}",
          size = 20,
        },

        -- Progress bar styling
        progress = {
          color = "${colors.blue.hex}",
          background = "${colors.surface0.hex}",
          height = 4,
        },
      },

      -- Urgency-specific styling
      urgency = {
        low = {
          background = "${colors.mantle.hex}",
          border_color = "${colors.surface1.hex}",
          timeout = 3000,
        },
        normal = {
          background = "${colors.mantle.hex}",
          border_color = "${colors.blue.hex}",
          timeout = 5000,
        },
        critical = {
          background = "${colors.mantle.hex}",
          border_color = "${colors.red.hex}",
          timeout = 0,  -- Critical notifications don't auto-dismiss
        },
      },

      -- Animation settings
      animation = {
        enabled = true,
        duration = 200,  -- milliseconds
      },

      -- Icon settings
      icons = {
        enabled = true,
        size = 48,
        theme = "Papirus",
      },
    }
  '';

in {
  home.packages = with pkgs; [
    # Add moxnotify when it's available in nixpkgs
    # For now, you may need to build it from source or use an overlay
  ];

  home.file.".config/moxnotify/config.lua".source = moxnotifyConfig;

  # Enable moxnotify service
  systemd.user.services.moxnotify = {
    Unit = {
      Description = "Moxnotify notification daemon";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };

    Service = {
      Type = "simple";
      ExecStart = "${pkgs.moxnotify}/bin/moxnotify";
      Restart = "on-failure";
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
