# Rmenu Configuration
# Application launcher for both X11 and Wayland
# Replaces rofi with Catppuccin Macchiato theme

{ config, pkgs, lib, ... }:

{
  home.file = {
    # Main rmenu config
    ".config/rmenu/config.yaml".text = ''
      # Rmenu Configuration
      # Application launcher with CSS styling

      # Terminal for running commands
      terminal: kitty

      # Search behavior
      search_matching: fuzzy
      search_debounce: 50

      # UI Settings
      placeholder: "Search..."
      icon_size: 24
      show_icons: true

      # Window settings
      window:
        width: 600
        height: 400
        anchor: center

      # Plugin settings
      plugins:
        drun:
          show_descriptions: true
          show_categories: false

        run:
          show_descriptions: false

        network:
          nm_applet: true

        powermenu:
          commands:
            shutdown: "systemctl poweroff"
            reboot: "systemctl reboot"
            logout: "pkill -KILL -u $USER"
            suspend: "systemctl suspend"
            lock: "i3lock -c 24273a"
    '';

    # CSS styling for rmenu
    ".config/rmenu/style.css".text = ''
      /* Rmenu CSS Theme - Catppuccin Macchiato */

      * {
        font-family: "SpaceMono Nerd Font";
        font-size: 14px;
      }

      /* Main window */
      window {
        background-color: #24273a;
        border: 1px solid #363a4f;
        border-radius: 12px;
        padding: 10px;
      }

      /* Search box */
      entry {
        background-color: #1e2030;
        color: #cad3f5;
        border: 1px solid #494d64;
        border-radius: 8px;
        padding: 8px 12px;
        margin-bottom: 10px;
      }

      entry:focus {
        border-color: #ed8796;
        outline: none;
      }

      entry::placeholder {
        color: #5b6078;
      }

      /* List items */
      list {
        background-color: transparent;
      }

      row {
        background-color: transparent;
        color: #cad3f5;
        padding: 8px 12px;
        border-radius: 8px;
        margin: 2px 0;
      }

      row:hover {
        background-color: #363a4f;
      }

      row:selected {
        background-color: #494d64;
        color: #ed8796;
      }

      /* Item labels */
      label {
        color: #cad3f5;
      }

      row:selected label {
        color: #ed8796;
      }

      /* Item descriptions */
      .description {
        color: #b8c0e0;
        font-size: 12px;
      }

      row:selected .description {
        color: #f5bde6;
      }

      /* Icons */
      image {
        margin-right: 12px;
      }

      /* Scrollbar */
      scrollbar {
        background-color: transparent;
        width: 8px;
      }

      scrollbar slider {
        background-color: #494d64;
        border-radius: 8px;
      }

      scrollbar slider:hover {
        background-color: #5b6078;
      }

      /* Power menu specific styling */
      .powermenu-button {
        background-color: #363a4f;
        color: #cad3f5;
        border: none;
        border-radius: 8px;
        padding: 12px 24px;
        margin: 4px;
      }

      .powermenu-button:hover {
        background-color: #494d64;
      }

      .powermenu-button.shutdown {
        color: #ed8796;
      }

      .powermenu-button.reboot {
        color: #eed49f;
      }

      .powermenu-button.logout {
        color: #f5a97f;
      }

      .powermenu-button.suspend {
        color: #8aadf4;
      }

      .powermenu-button.lock {
        color: #a6da95;
      }
    '';
  };
}
