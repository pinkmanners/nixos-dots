{ config, pkgs, lib, hostname, ... }:

{
  # ----- program configs -----
  imports = [
    # commons
    ../share/common.nix
    ../share/common-dd.nix
    ../share/common-music.nix

    # hyprland
    ../bin/hyprland/default.nix
    ../bin/waybar/default.nix
    ../bin/moxnotify/default.nix

    # leftwm
    #../bin/leftwm/default.nix
    #../bin/xmobar/default.nix
    #../bin/wired/default.nix

    # other
    ../bin/alacritty/default.nix
    ../bin/konsole/default.nix
    ../bin/oh-my-posh/default.nix
    ../bin/rofi/default.nix
    ../bin/zed-editor/default.nix
  ];
}
