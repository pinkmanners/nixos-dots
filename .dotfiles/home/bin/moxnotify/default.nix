# Moxnotify Configuration
# Notification daemon for Wayland/Hyprland
# Replaces SwayNC with Catppuccin Macchiato theme

{ config, pkgs, lib, ... }:

{
  home.file.".config/moxnotify/config.json".text = ''
    {
      "$schema": "/etc/xdg/moxnotify/configSchema.json",
      "positionX": "right",
      "positionY": "top",
      "timeout": 10,
      "timeout-low": 5,
      "timeout-critical": 0,
      "keyboard-shortcuts": true,
      "image-size": 100,
      "image-radius": 12,
      "notification-icon-size": 24,
      "notification-body-image-height": 100,
      "notification-body-image-width": 200,
      "transition-time": 200,
      "notification-window-width": 400,
      "fit-to-screen": true,
      "control-center-margin-top": 10,
      "control-center-margin-bottom": 10,
      "control-center-margin-right": 10,
      "control-center-margin-left": 0,
      "control-center-width": 400,
      "control-center-height": 600,
      "notification-2fa-action": true,
      "notification-inline-replies": false,
      "widgets": [
        "title",
        "dnd",
        "notifications"
      ],
      "widget-config": {
        "title": {
          "text": "Notifications",
          "clear-all-button": true,
          "button-text": "Clear All"
        },
        "dnd": {
          "text": "Do Not Disturb"
        },
        "notifications": {
          "text": "Notifications"
        }
      },
      "scripts": {}
    }
  '';

  home.file.".config/moxnotify/style.css".text = ''
    /* Moxnotify CSS Theme - Catppuccin Macchiato */

    * {
      all: unset;
      font-size: 14px;
      font-family: "SpaceMono Nerd Font";
      transition: 200ms;
    }

    /* Notification window */
    .notification-background {
      box-shadow: 0 0 8px 0 rgba(0, 0, 0, 0.8), inset 0 0 0 1px #494d64;
      border-radius: 12px;
      margin: 18px;
      background: #1e2030;
      color: #cad3f5;
      padding: 0;
    }

    .notification-background .notification {
      padding: 7px;
      border-radius: 12px;
    }

    .notification-background .notification.critical {
      box-shadow: inset 0 0 7px 0 #ed8796;
    }

    .notification .notification-content {
      margin: 7px;
    }

    .notification-content .summary {
      color: #cad3f5;
      font-weight: bold;
    }

    .notification-content .time {
      color: #a5adcb;
      font-size: 12px;
    }

    .notification-content .body {
      color: #b8c0e0;
    }

    .notification > *:last-child > * {
      min-height: 3.4em;
    }

    /* Close button */
    .notification-background .close-button {
      margin: 7px;
      padding: 2px;
      border-radius: 6px;
      color: #24273a;
      background-color: #ed8796;
    }

    .notification-background .close-button:hover {
      background-color: #ee99a0;
    }

    .notification-background .close-button:active {
      background-color: #f5bde6;
    }

    /* Action buttons */
    .notification .notification-action {
      border-radius: 7px;
      color: #cad3f5;
      background-color: #363a4f;
      box-shadow: inset 0 0 0 1px #494d64;
      margin: 4px;
      padding: 8px;
    }

    .notification .notification-action:hover {
      background-color: #494d64;
    }

    .notification .notification-action:active {
      background-color: #5b6078;
    }

    /* Progress bar */
    .notification.critical progress {
      background-color: #ed8796;
    }

    .notification.low progress,
    .notification.normal progress {
      background-color: #8aadf4;
    }

    .notification progress,
    .notification trough,
    .notification progressbar {
      border-radius: 12px;
      padding: 3px 0;
    }

    /* Control Center */
    .control-center {
      box-shadow: 0 0 8px 0 rgba(0, 0, 0, 0.8), inset 0 0 0 1px #363a4f;
      border-radius: 12px;
      background-color: #24273a;
      color: #cad3f5;
      padding: 14px;
    }

    .control-center .notification-background {
      border-radius: 7px;
      box-shadow: inset 0 0 0 1px #494d64;
      margin: 4px 10px;
    }

    .control-center .notification-background .notification {
      border-radius: 7px;
    }

    .control-center .notification-background .notification.low {
      opacity: 0.8;
    }

    /* Widget title */
    .control-center .widget-title > label {
      color: #cad3f5;
      font-size: 1.3em;
      font-weight: bold;
    }

    .control-center .widget-title button {
      border-radius: 7px;
      color: #cad3f5;
      background-color: #363a4f;
      box-shadow: inset 0 0 0 1px #494d64;
      padding: 8px;
    }

    .control-center .widget-title button:hover {
      background-color: #494d64;
    }

    .control-center .widget-title button:active {
      background-color: #5b6078;
    }

    /* Notification group */
    .control-center .notification-group {
      margin-top: 10px;
    }

    .control-center .notification-group:focus .notification-background {
      background-color: #363a4f;
    }

    /* Scrollbar */
    scrollbar slider {
      margin: -3px;
      opacity: 0.8;
      background-color: #494d64;
      border-radius: 8px;
    }

    scrollbar slider:hover {
      background-color: #5b6078;
    }

    scrollbar trough {
      margin: 2px 0;
      background-color: transparent;
    }

    /* DND widget */
    .widget-dnd {
      margin-top: 5px;
      border-radius: 8px;
      font-size: 1.1rem;
      background-color: #363a4f;
      padding: 8px;
    }

    .widget-dnd > switch {
      font-size: initial;
      border-radius: 8px;
      background: #363a4f;
      box-shadow: none;
    }

    .widget-dnd > switch:checked {
      background: #8aadf4;
    }

    .widget-dnd > switch slider {
      background: #494d64;
      border-radius: 8px;
    }
  '';
}
