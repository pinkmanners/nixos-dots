{ lib }:

{
  # Catppuccin Macchiato Color Palette
  # Source: https://catppuccin.com/palette/
  
  colors = {
    # Base colors
    rosewater = "#f4dbd6";
    flamingo = "#f0c6c6";
    pink = "#f5bde6";
    mauve = "#c6a0f6";
    red = "#ed8796";
    maroon = "#ee99a0";
    peach = "#f5a97f";
    yellow = "#eed49f";
    green = "#a6da95";
    teal = "#8bd5ca";
    sky = "#91d7e3";
    sapphire = "#7dc4e4";
    blue = "#8aadf4";
    lavender = "#b7bdf8";
    
    # Text colors
    text = "#cad3f5";
    subtext1 = "#b8c0e0";
    subtext0 = "#a5adcb";
    
    # Surface colors
    overlay2 = "#939ab7";
    overlay1 = "#8087a2";
    overlay0 = "#6e738d";
    surface2 = "#5b6078";
    surface1 = "#494d64";
    surface0 = "#363a4f";
    
    # Base/background colors
    base = "#24273a";
    mantle = "#1e2030";
    crust = "#181926";
  };

  # Convenience functions
  withAlpha = color: alpha: "${color}${alpha}";
  
  # Common color mappings for applications
  terminal = {
    # Standard ANSI colors
    black = "#494d64";           # surface1
    red = "#ed8796";             # red
    green = "#a6da95";           # green
    yellow = "#eed49f";          # yellow
    blue = "#8aadf4";            # blue
    magenta = "#f5bde6";         # pink
    cyan = "#8bd5ca";            # teal
    white = "#b8c0e0";           # subtext1
    
    # Bright ANSI colors
    brightBlack = "#5b6078";     # surface2
    brightRed = "#ed8796";       # red
    brightGreen = "#a6da95";     # green
    brightYellow = "#eed49f";    # yellow
    brightBlue = "#8aadf4";      # blue
    brightMagenta = "#f5bde6";   # pink
    brightCyan = "#8bd5ca";      # teal
    brightWhite = "#cad3f5";     # text
    
    # Terminal background/foreground
    background = "#24273a";      # base
    foreground = "#cad3f5";      # text
    cursor = "#f4dbd6";          # rosewater
    cursorText = "#24273a";      # base
  };

  # GTK theme colors
  gtk = {
    bg = "#24273a";              # base
    fg = "#cad3f5";              # text
    base = "#1e2030";            # mantle
    text = "#cad3f5";            # text
    selected_bg = "#c6a0f6";     # mauve
    selected_fg = "#24273a";     # base
    tooltip_bg = "#363a4f";      # surface0
    tooltip_fg = "#cad3f5";      # text
  };

  # Window manager colors
  wm = {
    focused = {
      border = "#c6a0f6";        # mauve
      background = "#24273a";    # base
      text = "#cad3f5";          # text
      indicator = "#f5bde6";     # pink
      childBorder = "#c6a0f6";   # mauve
    };
    unfocused = {
      border = "#363a4f";        # surface0
      background = "#1e2030";    # mantle
      text = "#6e738d";          # overlay0
      indicator = "#363a4f";     # surface0
      childBorder = "#363a4f";   # surface0
    };
    urgent = {
      border = "#ed8796";        # red
      background = "#24273a";    # base
      text = "#ed8796";          # red
      indicator = "#ed8796";     # red
      childBorder = "#ed8796";   # red
    };
  };

  # Notification colors
  notifications = {
    background = "#24273a";      # base
    foreground = "#cad3f5";      # text
    border = "#c6a0f6";          # mauve
    
    # Urgency levels
    low = "#a6da95";             # green
    normal = "#8aadf4";          # blue
    critical = "#ed8796";        # red
  };

  # Status bar colors
  statusbar = {
    background = "#24273a";      # base
    foreground = "#cad3f5";      # text
    border = "#363a4f";          # surface0
    
    # Module states
    active = "#c6a0f6";          # mauve
    inactive = "#6e738d";        # overlay0
    warning = "#eed49f";         # yellow
    critical = "#ed8796";        # red
    success = "#a6da95";         # green
  };

  # Rofi/launcher colors
  launcher = {
    background = "#24273a";      # base
    backgroundAlt = "#1e2030";   # mantle
    foreground = "#cad3f5";      # text
    selected = "#c6a0f6";        # mauve
    selectedFg = "#24273a";      # base
    border = "#c6a0f6";          # mauve
    separator = "#363a4f";       # surface0
  };

  # Meta information
  meta = {
    name = "Catppuccin Macchiato";
    author = "Catppuccin";
    homepage = "https://catppuccin.com";
    description = "Soothing pastel theme for the high-spirited!";
  };
}
