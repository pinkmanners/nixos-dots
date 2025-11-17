{ lib, stdenvNoCC, fetchFromGitHub}:

stdenvNoCC.mkDerivation rec {
  pname = "flatery-icon-theme";
  version = "2024-11-14";

  src = fetchFromGitHub {
    owner = "cbrnix";
    repo = "Flatery";
    rev = "30bef81ba98ac4c4f764e9fc1b705a86e0d27e2c";
    sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="; # update this hash ^_^
  };

  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/icons

    for theme in Flatery-*; do
      if [ -d "$theme" ]; then
        echo "Installing icon theme: $theme"
        cp -r "$theme" $out/share/icons/
      fi
    done

    find $out/share/icons -type f -exec chmod 644 {} \;
    find $out/share/icons -type d -exec chmod 755 {} \;

    runHook postInstall
  '';

  meta = with lib; {
    description = "Flatery icon theme";
    homepage = "https://github.com/cbrnix/Flatery";
  };
}
