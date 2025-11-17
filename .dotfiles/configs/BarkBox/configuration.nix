{ config, lib, pkgs, hostname, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../common.nix
  ];

  # systemd-boot for uefi systems
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # intel microcode
  hardware.cpu.intel.updateMicrocode = true;

  # legacy nvidia 470 drivers for the clunking ol' gtx 650 :p
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    package = config.boot.kernelPackages.nvidiaPackages.legacy_470;
    nvidiaSettings = true;
  };

  # need some graphics to be on
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = false;  # X11 only
    theme = "catppuccin-macchiato";
  };

  # oh xserver, my xserver...
  services.xserver = {
    enable = true;
    displayManager.sessionPackages = [ pkgs.leftwm ];

    # Desktop environment settings
    desktopManager.xterm.enable = false;

    # Keyboard layout
    xkb.layout = "us";
  };

  services.auto-cpufreq.enable = true;
  services.cpupower-gui.enable = true;
  services.ananicy = {
    enable = true;
    package = pkgs.ananicy-cpp;
    rulesProvider = pkgs.ananicy-rules-cachyos;
  };

  hardware.steam-hardware.enable = true;

  environment.systemPackages = with pkgs; [
    nvidia-vaapi-driver
  ]

  boot.extraModulePackages = with config.boot.kernelPackages; [
    xone
    xpadneo
  ];
}
