{ stdenv
, lib
, fetchFromGitHub
}:

stdenv.mkDerivation rec {
  pname = "flatery-icon-theme";
  version = "2024-12-01";

  src = fetchFromGitHub {
    owner = "cbrnix";
    repo = "Flatery";
    rev = "master";  # We'll pin this to a specific commit once installed
    sha256 = lib.fakeSha256;  # This will need to be updated on first build
  };

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/share/icons

    # Install all Flatery variants
    cp -r Flatery-* $out/share/icons/

    # Ensure proper permissions
    chmod -R 755 $out/share/icons
  '';

  meta = with lib; {
    description = "Flatery icon theme - A mix of icon packs for a more consistent look";
    homepage = "https://github.com/cbrnix/Flatery";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
    maintainers = [ ];
  };
}
