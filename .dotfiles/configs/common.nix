{ config, lib, pkgs, hostname, ... }:

{
  # keep ur computer zen ☯
  boot.kernelPackages = pkgs.linuxPackages_zen;

  networking.hostName = hostname;
  networking.networkmanager.enable = true;
  programs.nm-applet.enable = true;

  time.timeZone = "America/Toronto";
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "us";

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

  services.openssh.enable = lib.mkForce false;

  # ----- audio -----
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  # ----- kwallet + polkit-kde -----
  security.pam.services.sddm.enableKwallet = true;

  security.polkit.enable = true;
  systemd.user.services.polkit-kde-authentication-agent-1 = {
    description = "polkit-kde-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.libsForQt5.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  # ----- auto mount plz -----
  services.udisks2.enable = true;

  environment.systemPackages = with pkgs; [
    home-manager
    gnumake
    git
    wget
    curl
    neovim
    bat
    fd
    fzf
    lsd
    ripgrep
    htop
    btop
    nvtop
    mc
    yazi
    networkmanagerapplet
    kdePackages.kwalletmanager
    catppuccin-sddm
    light
  ];

  # fun things :3
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "SpaceMono" ]; })
  ];

  programs.zsh.enable = true;

  environment.variables = {
    EDITOR = "nvim";
    QT_QPA_PLATFORMTHEME = "kvantum";
    QT_STYLE_OVERRIDE = "kvantum";
  };

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.05";
}
