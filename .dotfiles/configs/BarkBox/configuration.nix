# BarkBox Configuration
# Custom desktop gaming machine
# Intel Core i5-3570K + NVIDIA GTX 650
# X11 only (LeftWM)

{ config, lib, pkgs, hostname, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # ===== SYSTEM BASICS =====

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Hostname
  networking.hostName = hostname;
  networking.networkmanager.enable = true;

  # Timezone and Locale
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "us";

  # ===== HARDWARE SUPPORT =====

  # Intel microcode
  hardware.cpu.intel.updateMicrocode = true;

  # NVIDIA Legacy 470 drivers for GTX 650
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    package = config.boot.kernelPackages.nvidiaPackages.legacy_470;
    nvidiaSettings = true;
  };

  # Enable OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # ===== DISPLAY MANAGER =====

  # SDDM on X11 for better NVIDIA compatibility
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = false;  # X11 only
    theme = "catppuccin-macchiato";
  };

  # X11 with LeftWM
  services.xserver = {
    enable = true;
    displayManager.sessionPackages = [ pkgs.leftwm ];

    # Desktop environment settings
    desktopManager.xterm.enable = false;

    # Keyboard layout
    xkb.layout = "us";
  };

  # ===== AUDIO =====

  # PipeWire with WirePlumber
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  # ===== SYSTEM SERVICES =====

  # NetworkManager applet support
  programs.nm-applet.enable = true;

  # Polkit authentication agent
  security.polkit.enable = true;
  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  # GNOME Keyring
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.sddm.enableGnomeKeyring = true;

  # Automatic mounting of removable media
  services.udisks2.enable = true;

  # Enable Steam hardware support
  hardware.steam-hardware.enable = true;

  # ===== USER ACCOUNT =====

  users.users.jayden = {
    isNormalUser = true;
    description = "Jayden";
    extraGroups = [
      "wheel"
      "networkmanager"
      "audio"
      "video"
      "input"
    ];
    shell = pkgs.zsh;
  };

  # ===== SYSTEM PACKAGES =====

  # Core system tools (GUI apps in home-manager)
  environment.systemPackages = with pkgs; [
    # Home-manager CLI for standalone usage
    home-manager

    # Build essentials
    gcc
    gnumake
    pkg-config

    # Core utilities (using Rust alternatives where possible)
    uutils-coreutils
    git
    wget
    curl

    # Editors
    neovim

    # Terminal tools
    bat
    fd
    fzf
    lsd

    # System monitoring
    htop
    btop
    nvtop  # For NVIDIA GPU monitoring

    # File management
    mc
    yazi
    xarchiver

    # Network tools
    networkmanagerapplet

    # Display/Graphics
    xorg.xeyes  # For testing X11

    # Polkit agent
    polkit_gnome

    # NVIDIA settings
    nvidia-vaapi-driver

    # Catppuccin SDDM theme
    catppuccin-sddm
  ];

  # ===== FONTS =====

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "SpaceMono" ]; })
  ];

  # ===== SHELL CONFIGURATION =====

  # Enable Zsh system-wide but don't make it default
  programs.zsh.enable = true;

  # Set default editor
  environment.variables.EDITOR = "nvim";

  # ===== NIX SETTINGS =====

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };

  # Allow unfree packages (required for NVIDIA drivers)
  nixpkgs.config.allowUnfree = true;

  # ===== SYSTEM STATE VERSION =====

  system.stateVersion = "25.05";
}
