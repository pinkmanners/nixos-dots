{ config, lib, pkgs, ... }:

{
  programs.zed-editor = {
    enable = true;

    extensions = [
      "catppuccin"
      "catppuccin-icons"
      "git-firefly"
      "html"
      "toml"
      "ruby"
      "xml"
      "log"
      "csv"
      "nix"
      "ini"
      "r"
      "cargo-tom"
      "hyprlang"
    ];

    userSettings = {
      show_edit_predictions = false;

      inlay_hints = {
        show_type_hints = false;
      };

      tabs = {
        close_position = "left";
      };

      agent = {
        use_modifier_to_send = true;
      };

      bottom_dock_layout = "contained";
      ui_font_weight = 400.0;
      ui_font_family = "Space Grotesk";
      use_system_prompts = false;
      use_system_path_prompts = false;
      when_closing_with_no_tabs = "keep_window_open";

      minimap = {
        show = "auto";
      };

      buffer_font_family = "Space Mono Nerd Font";

      icon_theme = "Catppuccin Macchiato";
      theme = {
        mode = "dark";
        light = "Catppuccin Macchiato";
        dark = "Catppuccin Macchiato";
      };

      telemetry = {
        diagnostics = false;
        metrics = false;
      };

      ui_font_size = 16;
      buffer_font_size = 15;
      soft_wrap = "editor_width";
    };
  };
}
