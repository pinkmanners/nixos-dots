# Home-Manager configuration for BarkBox
# Custom desktop gaming machine
# X11 only with LeftWM

{ config, pkgs, lib, hostname, ... }:

{
  # Basic home configuration
  home.username = "jayden";
  home.homeDirectory = "/home/jayden";
  home.stateVersion = "25.05";

  # Allow unfree packages for home-manager
  nixpkgs.config.allowUnfree = true;

  # ===== WINDOW MANAGER CONFIGURATION =====
  # Import X11/LeftWM configuration
  imports = [
    ../bin/leftwm/default.nix
    ../bin/xmobar/default.nix
    ../bin/rmenu/default.nix
    ../bin/wired/default.nix
    ../bin/kitty/default.nix
  ];

  # ===== ZSH CONFIGURATION =====
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    # Oh-my-zsh configuration
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [
        "git"
        "yt-dlp"
        "nix-shell"
        "nix-zsh-completions"
      ];
    };

    # History configuration
    history = {
      size = 10000;
      save = 10000;
      path = "${config.home.homeDirectory}/.histfile";
      ignoreAllDups = true;
    };

    # Environment variables
    sessionVariables = {
      EDITOR = "nvim";
      LANG = "en_US.UTF-8";
    };

    # FZF with Catppuccin Macchiato colors
    initExtra = ''
      # FZF + Catppuccin Macchiato
      export FZF_DEFAULT_OPTS=" \
      --color=bg+:#363A4F,bg:#24273A,spinner:#F4DBD6,hl:#ED8796 \
      --color=fg:#CAD3F5,header:#ED8796,info:#C6A0F6,pointer:#F4DBD6 \
      --color=marker:#B7BDF8,fg+:#CAD3F5,prompt:#C6A0F6,hl+:#ED8796 \
      --color=selected-bg:#494D64 \
      --color=border:#6E738D,label:#CAD3F5"

      # Source zsh-syntax-highlighting Catppuccin theme
      source ${config.home.homeDirectory}/.config/zsh/catppuccin_macchiato-zsh-syntax-highlighting.zsh

      # Custom settings
      unsetopt nomatch

      # Run fastfetch on shell start
      fastfetch --logo Xenia
    '';

    # Shell aliases
    shellAliases = {
      # Navigation
      cd.. = "cd ..";

      # List with lsd
      lsd = "lsd -l";

      # Quick commands
      q = "exit";
      c = "clear";

      # NixOS specific
      flakeUpdate = "nix flake update";
      rebuildSwitch = "sudo nixos-rebuild switch --flake /home/jayden/.dotfiles/#BarkBox";
      homeSwitch = "home-manager switch --flake /home/jayden/.dotfiles/#jayden@BarkBox";
    };
  };

  # Catppuccin zsh-syntax-highlighting theme file
  home.file.".config/zsh/catppuccin_macchiato-zsh-syntax-highlighting.zsh".text = ''
    # Catppuccin Macchiato theme for zsh-syntax-highlighting
    typeset -A ZSH_HIGHLIGHT_STYLES
    ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#ED8796'
    ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=#C6A0F6'
    ZSH_HIGHLIGHT_STYLES[alias]='fg=#A6DA95'
    ZSH_HIGHLIGHT_STYLES[builtin]='fg=#A6DA95'
    ZSH_HIGHLIGHT_STYLES[function]='fg=#A6DA95'
    ZSH_HIGHLIGHT_STYLES[command]='fg=#A6DA95'
    ZSH_HIGHLIGHT_STYLES[precommand]='fg=#A6DA95'
    ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=#F5BDE6'
    ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=#A6DA95'
    ZSH_HIGHLIGHT_STYLES[path]='fg=#8AADF4,underline'
    ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=#8AADF4,underline'
    ZSH_HIGHLIGHT_STYLES[path_approx]='fg=#8AADF4,underline'
    ZSH_HIGHLIGHT_STYLES[globbing]='fg=#8AADF4'
    ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=#C6A0F6'
    ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=#EED49F'
    ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=#EED49F'
    ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg=#C6A0F6'
    ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=#EED49F'
    ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=#EED49F'
    ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=#8AADF4'
    ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=#8AADF4'
    ZSH_HIGHLIGHT_STYLES[assign]='fg=#C6A0F6'
    ZSH_HIGHLIGHT_STYLES[redirection]='fg=#F5BDE6'
    ZSH_HIGHLIGHT_STYLES[comment]='fg=#5B6078'
    ZSH_HIGHLIGHT_STYLES[named-fd]='none'
    ZSH_HIGHLIGHT_STYLES[numeric-fd]='none'
    ZSH_HIGHLIGHT_STYLES[arg0]='fg=#8AADF4'
    ZSH_HIGHLIGHT_STYLES[bracket-error]='fg=#ED8796'
    ZSH_HIGHLIGHT_STYLES[bracket-level-1]='fg=#8AADF4'
    ZSH_HIGHLIGHT_STYLES[bracket-level-2]='fg=#A6DA95'
    ZSH_HIGHLIGHT_STYLES[bracket-level-3]='fg=#EED49F'
    ZSH_HIGHLIGHT_STYLES[bracket-level-4]='fg=#C6A0F6'
    ZSH_HIGHLIGHT_STYLES[bracket-level-5]='fg=#F5BDE6'
    ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]='standout'
  '';

  # ===== NEOVIM CONFIGURATION =====
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      # Theme
      catppuccin-nvim

      # Status line
      vim-airline
      vim-airline-themes

      # Kitty integration
      vim-kitty
    ];

    extraConfig = ''
      " Set colors to catppuccin
      colorscheme catppuccin-macchiato
      let g:airline_theme = 'catppuccin'
    '';
  };

  # ===== GIT CONFIGURATION =====
  programs.git = {
    enable = true;
    userName = "pinkmanners";
    userEmail = "inbox@pinkmanners.cc";
  };

  # ===== HOME PACKAGES =====
  home.packages = with pkgs; [
    # ==== GAMING & EMULATION ====
    prismlauncher

    # ==== MEDIA & CREATIVE ====
    # Photo/Image tools
    darktable
    xnconvert
    inkscape
    krita

    # Video tools
    handbrake
    mpv

    # Audio tools
    strawberry
    soundconverter

    # Media server
    plex-desktop

    # ==== UTILITIES ====
    # Web browser
    brave

    # Download tool
    yt-dlp

    # Communication
    telegram-desktop

    # Archive tools
    peazip

    # Office suite
    onlyoffice-bin

    # Note taking
    logseq

    # ==== SHARED GUI APPS ====
    # File managers
    thunar
    xarchiver

    # Terminals
    terminator

    # Text editors
    gedit

    # Utilities
    catfish
    gpick
    gparted
    gnome-disk-utility

    # VPN
    mullvad-vpn

    # Browsers
    mullvad-browser

    # Media players
    rhythmbox
    tenacity
    audacity
    vlc
    ristretto

    # Graphics
    gimp

    # Document viewer
    gnome-font-viewer
    gnome-papers

    # Text editor
    zed-editor

    # Password manager
    bitwarden

    # Torrent client
    transmission_4-qt

    # Office suite (shared)
    libreoffice-fresh

    # Compression
    p7zip

    # Video codecs
    ffmpeg
  ];

  # ===== STEAM CONFIGURATION =====
  # Steam with gaming optimizations for older hardware
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

  # Enable Steam via home packages
  home.packages = with pkgs; [
    steam
    steam-run

    # Additional gaming tools
    gamemode
    mangohud
  ];

  # ===== GTK THEMING =====
  gtk = {
    enable = true;

    theme = {
      name = "Catppuccin-Macchiato-Standard-Mauve-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "mauve" ];
        variant = "macchiato";
      };
    };

    iconTheme = {
      name = "Flatery-Red-Dark";
      package = pkgs.flatery-icon-theme;
    };

    cursorTheme = {
      name = "Mocu-Black-Right-X";
      package = pkgs.mocu-cursors;
      size = 32;
    };

    font = {
      name = "SpaceMono Nerd Font";
      size = 12;
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };

  # ===== QT THEMING =====
  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style = {
      name = "kvantum";
      package = pkgs.catppuccin-kvantum;
    };
  };

  # Configure Kvantum
  home.file.".config/Kvantum/kvantum.kvconfig".text = ''
    [General]
    theme=Catppuccin-Macchiato-Mauve
  '';

  # ===== XDG =====
  xdg = {
    enable = true;

    userDirs = {
      enable = true;
      createDirectories = true;
      desktop = "${config.home.homeDirectory}/Desktop";
      documents = "${config.home.homeDirectory}/Documents";
      download = "${config.home.homeDirectory}/Downloads";
      music = "${config.home.homeDirectory}/Music";
      pictures = "${config.home.homeDirectory}/Pictures";
      videos = "${config.home.homeDirectory}/Videos";
    };

    mimeApps = {
      enable = true;
      defaultApplications = {
        "text/html" = "brave-browser.desktop";
        "x-scheme-handler/http" = "brave-browser.desktop";
        "x-scheme-handler/https" = "brave-browser.desktop";
        "x-scheme-handler/about" = "brave-browser.desktop";
        "x-scheme-handler/unknown" = "brave-browser.desktop";
        "inode/directory" = "thunar.desktop";
      };
    };
  };

  # ===== PROGRAMS =====
  # Enable home-manager
  programs.home-manager.enable = true;
}
