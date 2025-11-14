{ lib
, stdenvNoCC
}:

stdenvNoCC.mkDerivation rec {
  pname = "mocu-cursors";
  version = "custom";

  # Placeholder - you'll add your custom cursor files to these directories
  src = ./sources;

  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/icons

    # Install Hyprcursor variants (for Wayland/Hyprland)
    if [ -d "hyprcursor" ]; then
      echo "Installing Hyprcursor themes..."
      for theme in hyprcursor/Mocu-*; do
        if [ -d "$theme" ]; then
          theme_name=$(basename "$theme")
          echo "  - Installing $theme_name"
          cp -r "$theme" $out/share/icons/
        fi
      done
    fi

    # Install XCursor variants (for X11/LeftWM)
    if [ -d "xcursor" ]; then
      echo "Installing XCursor themes..."
      for theme in xcursor/Mocu-*; do
        if [ -d "$theme" ]; then
          theme_name=$(basename "$theme")
          echo "  - Installing $theme_name"
          cp -r "$theme" $out/share/icons/
        fi
      done
    fi

    # Ensure proper permissions
    find $out/share/icons -type f -exec chmod 644 {} \;
    find $out/share/icons -type d -exec chmod 755 {} \;

    runHook postInstall
  '';

  meta = with lib; {
    description = "Mocu custom cursor themes for Hyprland and X11";
    license = licenses.unfree; # Adjust based on your cursor license
    platforms = platforms.linux;
    maintainers = [ ];
  };
}
