{ config, lib, pkgs, hostname, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../common.nix
  ];

  # systemd-boot for uefi systems
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # extra boot modules
  boot.extraModulePackages = with config.boot.kernelPackages; [
    xone
    xpadneo
  ];

  # intel microcode
  hardware.cpu.intel.updateMicrocode = true;

  # legacy nvidia 470 drivers for the clunking ol' gtx 650 :p
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.nvidia.acceptLicense = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    package = config.boot.kernelPackages.nvidiaPackages.legacy_470;
    nvidiaSettings = true;
    open = false;
  };

  # need some graphics to be on
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    #theme = "catppuccin-macchiato-mauve";
  };

  # double display server be like
  #programs.hyprland = {
  #  enable = true;
  #  withUWSM = true;
  #  xwayland.enable = true;
  #};

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  services.ananicy = {
    enable = true;
    package = pkgs.ananicy-cpp;
    rulesProvider = pkgs.ananicy-rules-cachyos;
  };

  hardware.steam-hardware.enable = true;

  environment.systemPackages = with pkgs; [
    nvidia-vaapi-driver
    nvtopPackages.nvidia
  ];

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    LIBVA_DRIVER_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };
}
