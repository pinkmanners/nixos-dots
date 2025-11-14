{ lib
, stdenvNoCC
, fetchFromGitHub
}:

stdenvNoCC.mkDerivation rec {
  pname = "flatery-icon-theme";
  version = "2024-11-14";

  src = fetchFromGitHub {
    owner = "cbrnix";
    repo = "Flatery";
    rev = "30bef81ba98ac4c4f764e9fc1b705a86e0d27e2c";
    sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="; # You'll need to update this hash
  };

  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/icons

    # Install all Flatery color variants
    for theme in Flatery-*; do
      if [ -d "$theme" ]; then
        echo "Installing icon theme: $theme"
        cp -r "$theme" $out/share/icons/
      fi
    done

    # Ensure proper permissions
    find $out/share/icons -type f -exec chmod 644 {} \;
    find $out/share/icons -type d -exec chmod 755 {} \;

    runHook postInstall
  '';

  meta = with lib; {
    description = "Flatery icon theme - all color variants";
    homepage = "https://github.com/cbrnix/Flatery";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
    maintainers = [ ];
  };
}
