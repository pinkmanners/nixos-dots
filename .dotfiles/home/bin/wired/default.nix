{ config, pkgs, lib, ... }:

{
  home.file.".config/wired/wired.ron".text = ''
    (
      // notification timeout in milliseconds
      timeout: 5000,

      // poll rate for checking notifications
      poll_interval: 16,

      // idle threshold before closing
      idle_threshold: 5000,

      // maximum number of notifications
      max_notifications: 5,

      // notification position
      anchor: TopRight,

      // offset from edge
      offset: (
        x: 10,
        y: 42,
      ),

      // notification layout
      layout_blocks: [
        (
          name: "root",
          parent: "",
          hook: Hook(parent_anchor: TL, self_anchor: TL),
          offset: Vec2(x: 0.0, y: 0.0),
          render_criteria: [
            (
              criteria: Urgency(Low),
              background_color: Color(hex: "#24273a"),
              border_color: Color(hex: "#7dc4e4"),
              border_width: 1.0,
            ),
            (
              criteria: Urgency(Normal),
              background_color: Color(hex: "#24273a"),
              border_color: Color(hex: "#7dc4e4"),
              border_width: 1.0,
            ),
            (
              criteria: Urgency(Critical),
              background_color: Color(hex: "#24273a"),
              border_color: Color(hex: "#ed8796"),
              border_width: 2.0,
            ),
          ],
        ),
        (
          name: "summary",
          parent: "root",
          hook: Hook(parent_anchor: TL, self_anchor: TL),
          offset: Vec2(x: 10.0, y: 10.0),
          render_criteria: [
            (
              criteria: All,
              text_color: Color(hex: "#cad3f5"),
              font: "SpaceMono Nerd Font Bold 12",
            ),
          ],
        ),
        (
          name: "body",
          parent: "summary",
          hook: Hook(parent_anchor: BL, self_anchor: TL),
          offset: Vec2(x: 0.0, y: 5.0),
          render_criteria: [
            (
              criteria: All,
              text_color: Color(hex: "#a5adcb"),
              font: "SpaceMono Nerd Font 10",
            ),
          ],
        ),
      ],
    )
  '';

  home.packages = with pkgs; [
    wired
  ];
}
