{ stdenv
, lib
, fetchFromGitHub
}:

stdenv.mkDerivation rec {
  pname = "mocu-cursors";
  version = "2024-12-01";

  src = fetchFromGitHub {
    owner = "charakterziffer";
    repo = "cursor-toolbox";
    rev = "main";  # Pin to specific commit on first build
    sha256 = lib.fakeSha256;  # Update on first build
  };

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/share/icons
    mkdir -p $out/share/cursors

    # Install X cursor themes
    if [ -d "build/xcursor" ]; then
      cp -r build/xcursor/Mocu-Black-Left-X $out/share/icons/
      cp -r build/xcursor/Mocu-White-Left-X $out/share/icons/
      cp -r build/xcursor/Mocu-Black-Right-X $out/share/icons/
      cp -r build/xcursor/Mocu-White-Right-X $out/share/icons/
    fi

    # Install Hyprcursor themes
    if [ -d "build/hyprcursor" ]; then
      cp -r build/hyprcursor/Mocu-Black-Left-H $out/share/cursors/
      cp -r build/hyprcursor/Mocu-White-Left-H $out/share/cursors/
      cp -r build/hyprcursor/Mocu-Black-Right-H $out/share/cursors/
      cp -r build/hyprcursor/Mocu-White-Right-H $out/share/cursors/
    fi

    # Ensure proper permissions
    chmod -R 755 $out/share/icons
    chmod -R 755 $out/share/cursors
  '';

  meta = with lib; {
    description = "Mocu cursor themes for X11 and Wayland (Hyprcursor)";
    homepage = "https://github.com/charakterziffer/cursor-toolbox";
    license = licenses.cc-by-40;
    platforms = platforms.linux;
    maintainers = [ ];
  };
}
