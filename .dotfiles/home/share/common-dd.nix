{ config, pkgs, lib, hostname, ... }:

{
  home.packages = with pkgs; [
    darktable
    xnconvert
    inkscape
    krita
    handbrake
    dragon
    stawberry
    soundconverter
    plex-desktop
    brave
    yt-dlp
    telegram-desktop
    peazip
    onlyoffice-bin
    logseq
    prismlauncher
  ]
}
