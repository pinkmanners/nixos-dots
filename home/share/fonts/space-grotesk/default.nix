final: prev: {
  space-grotesk-font = prev.stdenvNoCC.mkDerivation {
    pname = "space-grotesk-font";
    version = "2.1.0";

    src = ./src/space-grotesk.zip;

    nativeBuildInputs = [ prev.unzip ];

    dontBuild = true;

    installPhase = ''
      runHook preInstall

      mkdir -p $out/share/fonts/truetype
      find . -name "*.ttf" -exec cp {} $out/share/fonts/truetype/ \;

      runHook postInstall
    '';

    meta = {
      description = "Space Grotesk - A proportional sans-serif typeface";
      homepage = "https://github.com/floriankarsten/space-grotesk";
      license = prev.lib.licenses.ofl;
      platforms = prev.lib.platforms.all;
    };
  };
}
