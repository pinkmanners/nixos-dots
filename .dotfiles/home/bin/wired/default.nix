# Wired Notification Daemon Configuration
# For X11 with LeftWM
# Replicates SwayNC styling with Catppuccin Macchiato

{ config, pkgs, lib, ... }:

{
  home.file.".config/wired/wired.ron".text = ''
    (
        // Position and layout
        layout_blocks: [
            (
                name: "root",
                params: NotificationBlock((
                    monitor: 0,
                    border_width: 1.0,
                    border_rounding: 12.0,
                    background_color: Color(hex: "24273a"),
                    border_color: Color(hex: "494d64"),
                    gap: Vec2 { x: 0.0, y: 10.0 },
                    notification_hook: None,
                )),
            ),
            (
                name: "summary",
                parent: "root",
                params: TextBlock((
                    text: "%s",
                    font: "SpaceMono Nerd Font 12",
                    ellipsize: End,
                    color: Color(hex: "cad3f5"),
                    padding: Padding {
                        top: 7.0,
                        right: 7.0,
                        bottom: 0.0,
                        left: 7.0,
                    },
                    dimensions: (width: (min: 0, max: 350), height: (min: 0, max: 0)),
                )),
            ),
            (
                name: "body",
                parent: "root",
                params: TextBlock((
                    text: "%b",
                    font: "SpaceMono Nerd Font 10",
                    ellipsize: End,
                    color: Color(hex: "b8c0e0"),
                    padding: Padding {
                        top: 4.0,
                        right: 7.0,
                        bottom: 7.0,
                        left: 7.0,
                    },
                    dimensions: (width: (min: 0, max: 350), height: (min: 0, max: 200)),
                )),
            ),
        ],

        // Notification behavior
        idle_threshold: 0,
        poll_interval: 16,
        history_length: 100,
        replacing_enabled: true,
        replacing_resets_timeout: true,
        closing_enabled: true,
        closing_closes_all: false,
        debug: false,
        debug_color: Color(hex: "ee99a0"),
        debug_color_alt: Color(hex: "ed8796"),

        // Shortcuts
        shortcuts: ShortcutsConfig (
            notification_interact: 1,
            notification_close: 2,
            notification_closeall: 3,
            notification_pause: 9,
        ),

        // Notification timeouts (in milliseconds)
        timeout_low: 5000,
        timeout_normal: 10000,
        timeout_critical: 0,  // Critical notifications don't timeout

        // Notification position and size
        max_notifications: 5,
        offset: Vec2 { x: 10.0, y: 42.0 },  // 42px from top to clear status bar
        notification_width: 350,
        notification_height: 100,
        gap: 10.0,
        growth_direction: Down,
        anchor: TopRight,

        // Notification hooks (for different urgency levels)
        low_urgency_hook: Hook (
            actions: [
                (
                    name: "set-color",
                    params: [("color", "#8aadf4")],
                ),
            ],
        ),

        normal_urgency_hook: Hook (
            actions: [
                (
                    name: "set-color",
                    params: [("color", "#8aadf4")],
                ),
            ],
        ),

        critical_urgency_hook: Hook (
            actions: [
                (
                    name: "set-color",
                    params: [("color", "#ed8796")],
                ),
            ],
        ),
    )
  '';
}
