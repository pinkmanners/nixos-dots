{ config, pkgs, lib, hostname, ... }:

{
  # ----- program configs -----
  imports = [
    # commons
    ../share/common.nix
    ../share/common-radio.nix
    ../bin/oh-my-posh/default.nix

    # leftwm
    ../bin/leftwm/default.nix
    ../bin/xmobar/default.nix
    ../bin/wired/default.nix

    # other
    ../bin/rmenu/default.nix

    ../bin/alacritty/default.nix

    ../bin/konsole/default.nix
  ];
}
