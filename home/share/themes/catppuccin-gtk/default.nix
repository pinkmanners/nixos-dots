final: prev: {
  catppuccin-gtk-theme = prev.stdenvNoCC.mkDerivation {
    pname = "catppuccin-gtk-theme";
    version = "1.0.0";

    src = ./src/catppuccin-mauve-dark-macchiato-gtk.zip;

    nativeBuildInputs = [ prev.unzip ];

    sourceRoot = ".";

    dontBuild = true;

    installPhase = ''
      runHook preInstall

      mkdir -p $out/share/themes

      # Copy the entire theme directory
      cp -r Catppuccin-Mauve-Dark-Macchiato $out/share/themes/
      cp -r Catppuccin-Mauve-Dark-Macchiato-hdpi $out/share/themes/
      cp -r Catppuccin-Mauve-Dark-Macchiato-xhdpi $out/share/themes/

      runHook postInstall
    '';

    meta = {
      description = "Catppuccin Mauve Dark Macchiato GTK theme";
      homepage = "https://github.com/Fausto-Korpsvart/Catppuccin-GTK-Theme";
      license = prev.lib.licenses.gpl3;
    };
  };
}
