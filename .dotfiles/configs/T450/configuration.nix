# T450 Configuration
# Primary tinkering/backup machine
# Intel i5-5300U, integrated graphics
# Supports both Hyprland (Wayland) and LeftWM (X11)

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

  # Intel integrated graphics (i915)
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      libvdpau-va-gl
    ];
  };

  # Enable OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # ===== POWER MANAGEMENT (TLP) =====

  # Balanced profile: Performance on AC, Power-saving on Battery
  services.tlp = {
    enable = true;
    settings = {
      # CPU Settings
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      # CPU Boost/Turbo
      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;

      # Energy Performance Policy
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

      # USB Autosuspend
      USB_AUTOSUSPEND = 0;  # Disable on AC
      USB_AUTOSUSPEND_ON_BAT = 1;  # Enable on Battery

      # Runtime PM for PCI(e) devices
      RUNTIME_PM_ON_AC = "on";
      RUNTIME_PM_ON_BAT = "auto";
    };
  };

  # ===== DISPLAY MANAGER =====

  # SDDM - supports both X11 and Wayland
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;  # Supports both X11 and Wayland sessions
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

  # Hyprland from nixpkgs
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # XDG Desktop Portal
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
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

    # File management
    mc
    yazi
    xarchiver

    # Network tools
    networkmanagerapplet

    # Display/Graphics
    xorg.xeyes  # For testing X11
    wl-clipboard  # For Wayland clipboard

    # Polkit agent
    polkit_gnome

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

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # ===== SYSTEM STATE VERSION =====

  system.stateVersion = "25.05";
}
