{ config, lib, pkgs, hostname, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../common.nix
  ];

  # grub for efi systems only
  boot.loader.grub = {
    enable = true;
    device = /dev/sda;
    useOSProber = true;
  };

  # intel microcode
  hardware.cpu.intel.updateMicrocode = true;

  # graphics on with intel drivers
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-vaapi-driver
      libvdpau-va-gl
    ];
  };

  # ----- power managment w/tlp -----
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;

      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";

      USB_AUTOSUSPEND = 0;  # Disable on AC
      USB_AUTOSUSPEND_ON_BAT = 1;  # Enable on Battery

      RUNTIME_PM_ON_AC = "on";
      RUNTIME_PM_ON_BAT = "auto";

      DISK_IDLE_SECS_ON_AC = 0;
      DISK_IDLE_SECS_ON_BAT = 2;

      START_CHARGE_THRESH_BAT0 = 50;
      STOP_CHARGE_THRESH_BAT0 = 80;
    };
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
