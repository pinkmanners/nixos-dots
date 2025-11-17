{ config, pkgs, lib, hostname, ... }:

{
  home.packages = with pkgs; [
    wsjtx
    xlog
    cqrlog
  ]
}
