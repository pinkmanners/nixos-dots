{ config, pkgs, lib, hostname, ... }:

{
  # ----- full steam ahead -----
  home.file.".local/share/applications/steam-gaming.desktop".text = ''
    [Desktop Entry]
    Name=Steam (Optimized)
    Comment=Application for managing and playing games on Steam (with optimizations)
    Exec=steam -console -nofriendsui -no-browser +@nClientDownloadEnableHTTP2PlatformLinux 0 %U
    Icon=steam
    Terminal=false
    Type=Application
    Categories=Network;FileTransfer;Game;
    MimeType=x-scheme-handler/steam;x-scheme-handler/steamlink;
  '';

  home.packages = with pkgs; [
    steam
    steam-run
    gamescope
    gamemode
    mangohud
    goverlay

    protonup-qt
    protontricks
    steamtinkerlaunch

    wine
    wine-staging
    winetricks
    bottles
    lutris
    heroic
    itch

    vkbasalt
    libstrangle

    antimicrox
    sc-controller
    ds4drv
    linuxConsoleTools
    cpupower-gui

    retroarch
    emulationstation-de
    obs-studio
    vesktop
  ];
}
