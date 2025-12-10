{ config, pkgs, lib, hostname, ... }:

{
  # ----- amateur radio packages -----
  home.packages = with pkgs; [
    wsjtx
    xlog
    cqrlog
    chirp
  ];
}
