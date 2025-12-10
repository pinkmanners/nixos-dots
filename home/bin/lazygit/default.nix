{ config, lib, pkgs, ... }:

{
  programs.lazygit = {
    enable = true;
    enableZshIntegration = true;
  };
}
