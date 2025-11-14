# Kitty Terminal Configuration
# Converted from Fedora dots
# Catppuccin Macchiato theme with SpaceMono Nerd Font

{ config, pkgs, lib, ... }:

{
  home.file.".config/kitty/kitty.conf".text = ''
    # Kitty Configuration
    # Catppuccin Macchiato Theme

    # ===== COLORS =====

    # The basic colors
    foreground              #cad3f5
    background              #24273a
    selection_foreground    #24273a
    selection_background    #f4dbd6

    # Cursor colors
    cursor                  #f4dbd6
    cursor_text_color       #24273a

    # URL underline color when hovering with mouse
    url_color               #f4dbd6

    # Kitty window border colors
    active_border_color     #ed8796
    inactive_border_color   #7dc4e4
    bell_border_color       #eed49f

    # OS Window titlebar colors
    wayland_titlebar_color  system
    macos_titlebar_color    system

    # Tab bar colors
    active_tab_foreground   #181926
    active_tab_background   #c6a0f6
    inactive_tab_foreground #cad3f5
    inactive_tab_background #1e2030
    tab_bar_background      #181926

    # Colors for marks (marked text in the terminal)
    mark1_foreground        #24273a
    mark1_background        #b7bdf8
    mark2_foreground        #24273a
    mark2_background        #c6a0f6
    mark3_foreground        #24273a
    mark3_background        #7dc4e4

    # The 16 terminal colors

    # black
    color0                  #494d64
    color8                  #5b6078

    # red
    color1                  #ed8796
    color9                  #ed8796

    # green
    color2                  #a6da95
    color10                 #a6da95

    # yellow
    color3                  #eed49f
    color11                 #eed49f

    # blue
    color4                  #8aadf4
    color12                 #8aadf4

    # magenta
    color5                  #f5bde6
    color13                 #f5bde6

    # cyan
    color6                  #8bd5ca
    color14                 #8bd5ca

    # white
    color7                  #b8c0e0
    color15                 #a5adcb

    # ===== FONT SETTINGS =====

    font_family             SpaceMono Nerd Font Bold
    bold_font               auto
    italic_font             auto
    bold_italic_font        auto
    font_size               12.0

    # ===== CURSOR =====

    cursor_shape            underline
    cursor_underline_thickness 2.0
    cursor_blink_interval   -1
    cursor_trail            1
    cursor_trail_start_threshold 1
    cursor_trail_decay      0.1 0.2

    # ===== SCROLLBACK =====

    scrollback_lines        2000
    scrollback_indicator_opacity 1.0

    # ===== MOUSE =====

    mouse_hide_wait         -1
    url_prefixes            file ftp ftps gemini git gopher http https irc ircs kitty mailto news sftp ssh
    detect_urls             yes
    show_hyperlink_targets  no
    underline_hyperlinks    hover
    click_interval          -1

    # ===== PERFORMANCE TUNING =====

    sync_to_monitor         yes

    # ===== BELL =====

    enable_audio_bell       yes
    visual_bell_duration    0.0
    command_on_bell         notify-send "Command has finished running in kitty ^_^"

    # ===== WINDOW LAYOUT =====

    remember_window_size    no
    remember_window_position no
    window_border_width     1px
    hide_window_decorations yes

    # ===== TAB BAR =====

    tab_bar_edge            top
    tab_bar_margin_width    0
    tab_bar_margin_height   0.0 0.0
    tab_bar_style           powerline
    tab_powerline_style     angled
    tab_bar_align           left
    tab_bar_min_tabs        2
    tab_activity_symbol     ...
    tab_title_max_length    15
    tab_title_template      "{fmt.fg.red}{bell_symbol}{activity_symbol}{fmt.fg.tab}{tab.last_focused_progress_percent}{title}"

    # ===== BACKGROUND TWEAKS =====

    background_opacity      0.9
    background_blur         0

    # ===== ADVANCED =====

    editor                  nvim
    allow_hyperlinks        yes
    shell_integration       no-cursor

    # ===== KEYMAPS =====

    kitty_mod               ctrl+shift
    map f1                  launch_tab nvim

    # Clipboard
    map kitty_mod+c         copy_to_clipboard
    map kitty_mod+s         paste_from_selection

    # Scrolling
    map ctrl+shift+up       scroll_line_up
    map ctrl+shift+k        scroll_line_up
    map ctrl+shift+down     scroll_line_down
    map ctrl+shift+j        scroll_line_down
    map ctrl+shift+page_up  scroll_page_up
    map ctrl+shift+page_down scroll_page_down
    map ctrl+shift+home     scroll_home
    map ctrl+shift+end      scroll_end
    map ctrl+shift+z        scroll_to_prompt -1
    map ctrl+shift+x        scroll_to_prompt 1
    map ctrl+shift+h        show_scrollback

    # Windows
    map kitty_mod+n         new_os_window
    map alt+shift+n         new_os_window_with_cwd

    # Tabs
    map kitty_mod+right     next_tab
    map kitty_mod+left      previous_tab
    map ctrl+shift+t        new_tab
    map ctrl+shift+q        close_tab
    map ctrl+shift+.        move_tab_forward
    map ctrl+shift+,        move_tab_backward
    map ctrl+alt+1          goto_tab 1
    map ctrl+alt+2          goto_tab 2
    map ctrl+alt+3          goto_tab 3
    map ctrl+alt+4          goto_tab 4
    map ctrl+alt+5          goto_tab 5
    map ctrl+alt+6          goto_tab 6
    map ctrl+alt+7          goto_tab 7
    map ctrl+alt+8          goto_tab 8
    map ctrl+alt+9          goto_tab 9
    map ctrl+alt+0          goto_tab 10

    # Font size
    map ctrl+shift+equal    change_font_size all +2.0
    map ctrl+shift+plus     change_font_size all +2.0
    map ctrl+shift+kp_add   change_font_size all +2.0
    map ctrl+shift+minus    change_font_size all -2.0
    map ctrl+shift+kp_subtract change_font_size all -2.0
    map ctrl+shift+backspace change_font_size all 0

    # Misc
    map ctrl+shift+f1       show_kitty_doc overview
    map ctrl+shift+f2       edit_config_file
    map f10                 load_config_file
    map f11                 clear_terminal reset active
  '';
}
