{ config, pkgs, lib, hostname, ... }:

{
  # ----- daily driver packages -----
  home.packages = with pkgs; [
    # audio/music
    strawberry
    soundconverter

    # video/media players
    kdePackages.dragon
    plex-desktop

    # image viewers/editors
    darktable
    xnconvert
    krita
    inkscape

    # file management/utilities
    peazip

    # document viewers/office
    onlyoffice-desktopeditors

    # productivity/notes
    logseq

    # internet/network
    brave
    telegram-desktop
    yt-dlp

    # password management
    bitwarden-desktop

    # video processing
    handbrake
    ffmpeg

    # gaming
    prismlauncher
  ];
}
