{ config, lib, pkgs, ... }:

{
  programs.alacritty = {
    enable = true;

    settings = {
      general = {
        live_config_reload = true;
      };

      env = {
        TERM = "xterm-256color";
      };

      window = {
        padding = {
          x = 10;
          y = 10;
        };
        decorations = "full";
        opacity = 1.0;
        dynamic_padding = false;
      };

      scrolling = {
        history = 10000;
        multiplier = 3;
      };

      font = {
        normal = {
          family = "SpaceMono Nerd Font";
          style = "Regular";
        };
        bold = {
          family = "SpaceMono Nerd Font";
          style = "Bold";
        };
        italic = {
          family = "SpaceMono Nerd Font";
          style = "Italic";
        };
        bold_italic = {
          family = "SpaceMono Nerd Font";
          style = "Bold Italic";
        };
        size = 12.0;
      };

      # catppuccin macchiato
      colors = {
        primary = {
          background = "#24273a";
          foreground = "#cad3f5";
          dim_foreground = "#8087a2";
          bright_foreground = "#cad3f5";
        };

        cursor = {
          text = "#24273a";
          cursor = "#f4dbd6";
        };

        vi_mode_cursor = {
          text = "#24273a";
          cursor = "#b7bdf8";
        };

        search = {
          matches = {
            foreground = "#24273a";
            background = "#a5adcb";
          };
          focused_match = {
            foreground = "#24273a";
            background = "#a6da95";
          };
        };

        footer_bar = {
          foreground = "#24273a";
          background = "#a5adcb";
        };

        hints = {
          start = {
            foreground = "#24273a";
            background = "#eed49f";
          };
          end = {
            foreground = "#24273a";
            background = "#a5adcb";
          };
        };

        selection = {
          text = "#24273a";
          background = "#f4dbd6";
        };

        normal = {
          black = "#494d64";
          red = "#ed8796";
          green = "#a6da95";
          yellow = "#eed49f";
          blue = "#8aadf4";
          magenta = "#f5bde6";
          cyan = "#8bd5ca";
          white = "#b8c0e0";
        };

        bright = {
          black = "#5b6078";
          red = "#ed8796";
          green = "#a6da95";
          yellow = "#eed49f";
          blue = "#8aadf4";
          magenta = "#f5bde6";
          cyan = "#8bd5ca";
          white = "#a5adcb";
        };

        indexed_colors = [
          { index = 16; color = "#f5a97f"; }
          { index = 17; color = "#f4dbd6"; }
        ];
      };

      bell = {
        animation = "EaseOutExpo";
        duration = 0;
        color = "#ffffff";
      };

      mouse = {
        hide_when_typing = true;
      };

      # url hints
      hints = {
        enabled = [
          {
            regex = ''(ipfs:|ipns:|magnet:|mailto:|gemini:|gopher:|https:|http:|news:|file:|git:|ssh:|ftp:)[^\u0000-\u001f\u007f-\u009f<>"\\s{-}\\^⟨⟩`]+'';
            command = "xdg-open";
            post_processing = true;
            mouse = {
              enabled = true;
              mods = "None";
            };
            binding = {
              key = "U";
              mods = "Control|Shift";
            };
          }
        ];
      };

      cursor = {
        style = {
          shape = "Underline";
          blinking = "On";
        };
        unfocused_hollow = true;
      };

      # use this to change ur shell
      # shell = {
      #   program = "/usr/bin/zsh";
      # };
    };
  };
}
