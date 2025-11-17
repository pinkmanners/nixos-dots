{ lib, stdenvNoCC}:

stdenvNoCC.mkDerivation rec {
  pname = "mocu-cursors";
  version = "custom";

  src = ./src;

  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/icons

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

    find $out/share/icons -type f -exec chmod 644 {} \;
    find $out/share/icons -type d -exec chmod 755 {} \;

    runHook postInstall
  '';

  meta = with lib; {
    description = "Mocu cursor themes for Hyprland and X11";
    homepage = "https://github.com/sevmeyer/mocu-xcursor";
  };
}
