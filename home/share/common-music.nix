{ config, pkgs, lib, hostname, ... }:

{
  # ----- music production packages -----
  home.packages = with pkgs; [
    mixxx
    xwax
    ardour

    reaper
    reaper-sws-extension
    reaper-reapack-extension
  ];
}
