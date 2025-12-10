{ config, lib, pkgs, hostname, ... }:

{
  # keep ur computer zen ☯
  boot.kernelPackages = pkgs.linuxPackages_zen;

  # ----- user -----
  users.users.jayden = {
    isNormalUser = true;
    description = "jayden ♡";
    extraGroups = [
      "wheel"
      "networkmanager"
      "audio"
      "video"
      "input"
    ];
    shell = pkgs.zsh;
  };

  # ----- timezone/locale -----
  time.timeZone = "America/Toronto";
  i18n.defaultLocale = "en_CA.UTF-8";
  console.keyMap = "us";


  # ----- networking -----
  networking.hostName = hostname;
  networking.firewall.enable = true;
  networking.networkmanager.enable = true;
  programs.nm-applet.enable = true;

  services.openssh.enable = lib.mkForce false;


  # ----- catppuccin -----
  catppuccin = {
    enable = true;
    flavor = "macchiato";
    accent = "mauve";
  };


  # ----- audio -----
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };


  # ----- thunar file manager -----
  services.gvfs.enable = true;      # mount, trash, and other functionalities
  services.tumbler.enable = true;   # thumbnail support for images
  programs.xfconf.enable = true;    # save config options

  # enable it with plugins
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-volman
      thunar-vcs-plugin
      thunar-archive-plugin
      thunar-media-tags-plugin
    ];
  };


  # ----- kwallet + polkit-kde -----
  security.pam.services.sddm.enableKwallet = true;
  systemd.user.services.kwallet = {
    description = "KWallet daemon";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.kdePackages.kwallet}/bin/kwalletd6";
      Restart = "on-failure";
    };
  };

  security.polkit.enable = true;
  systemd.user.services.polkit-kde-authentication-agent-1 = {
    description = "polkit-kde-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };


  # ----- disk mounting -----
  services.udisks2.enable = true;


  # ----- system packages -----
  nixpkgs.config.allowUnfree = true;
  services.gnome.core-apps.enable = lib.mkForce false;  # no gnome crap plz

  environment.systemPackages = with pkgs; [
    # home manager, duh...
    home-manager

    # build tools
    gnumake

    # version control
    git

    # network tools
    wget
    curl
    networkmanagerapplet

    # text editors
    neovim

    # file utilities
    bat
    fd
    lsd
    ripgrep

    # file managers
    yazi
    mc

    # search/navigation
    fzf

    # system monitoring
    bottom
    htop
    btop

    # credential management
    kdePackages.kwallet
    kdePackages.kwallet-pam
    kdePackages.kwalletmanager

    # hardware control
    brightnessctl
    playerctl

    # hardware information
    pciutils
    usbutils
  ];

  # ----- fun things :3 -----

  # fonts
  fonts.packages = with pkgs; [
    nerd-fonts.space-mono
    space-grotesk-font
  ];

  # enable zsh
  programs.zsh.enable = true;

  # set nvim as the default editor
  environment.variables = {
    EDITOR = "nvim";
  };

  # gimme that flake
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };

  # clean up ur system
  nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
  };

  # match with flake.nix!
  system.stateVersion = "25.11";
}
