{ config, pkgs, lib, hostname, ... }:

{
  imports = [
    ./mimeapps.nix
  ];

  # ----- home stuffs -----
  home.username = "jayden";
  home.homeDirectory = "/home/jayden";
  home.stateVersion = "25.11";
  programs.home-manager.enable = true;


  # ----- zsh -----

  # enable shell integration
  home.shell.enableZshIntegration = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history = {
      size = 10000;
      save = 10000;
      path = "${config.home.homeDirectory}/.histfile";
      ignoreAllDups = true;
    };

    completionInit = ''
      # hyphen-insensitive completion
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*'

      # ----- completion waiting dots -----
      #expand-or-complete-with-dots() {
      #  echo -n "%F{red} ...sit and wait like a good girl ^_^ %f"
      #  zle expand-or-complete
      #  zle redisplay
      #}
      #zle -N expand-or-complete-with-dots
      #bindkey "^I" expand-or-complete-with-dots

      autoload -Uz compinit
      compinit
    '';

    # env vars
    sessionVariables = {
      EDITOR = "nvim";
      LANG = "en_CA.UTF-8";
      QT_QPA_PLATFORMTHEME = "qt6ct";
      QT_STYLE_OVERRIDE = "kvantum";
    };

    # zinit + plugins
    initContent = ''
      # install zinit if its not present
      ZINIT_HOME="''${XDG_DATA_HOME:-''${HOME}/.local/share}/zinit/zinit.git"
      if [[ ! -f $ZINIT_HOME/zinit.zsh ]]; then
        print -P "%F{33}▓▒░ Installing zinit (zdharma-continuum/zinit)…%f"
        command mkdir -p "$(dirname $ZINIT_HOME)"
        command git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME" && \
          print -P "%F{34}▓▒░ Installation successful.%f" || \
          print -P "%F{160}▓▒░ Installation failed.%f"
      fi
      source "$ZINIT_HOME/zinit.zsh"

      # ----- plugins -----
      zinit light zdharma-continuum/fast-syntax-highlighting
      zinit light zsh-users/zsh-autosuggestions
      zinit light zsh-users/zsh-completions
      zinit light Aloxaf/fzf-tab
      zinit light chisui/zsh-nix-shell
      zinit snippet OMZP::git

      # ----- oh-my-posh -----
      eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/zen.toml)"

      # ----- fzf catppuccin -----
      export FZF_DEFAULT_OPTS=" \
      --color=bg+:#363A4F,bg:#24273A,spinner:#F4DBD6,hl:#ED8796 \
      --color=fg:#CAD3F5,header:#ED8796,info:#C6A0F6,pointer:#F4DBD6 \
      --color=marker:#B7BDF8,fg+:#CAD3F5,prompt:#C6A0F6,hl+:#ED8796 \
      --color=selected-bg:#494D64 \
      --color=border:#6E738D,label:#CAD3F5"

      # ----- catppuccin syntax highlighting -----
      typeset -gA FAST_HIGHLIGHT_STYLES
      FAST_HIGHLIGHT_STYLES[unknown-token]='fg=#ED8796'
      FAST_HIGHLIGHT_STYLES[reserved-word]='fg=#C6A0F6'
      FAST_HIGHLIGHT_STYLES[alias]='fg=#A6DA95'
      FAST_HIGHLIGHT_STYLES[builtin]='fg=#A6DA95'
      FAST_HIGHLIGHT_STYLES[function]='fg=#A6DA95'
      FAST_HIGHLIGHT_STYLES[command]='fg=#A6DA95'
      FAST_HIGHLIGHT_STYLES[precommand]='fg=#A6DA95'
      FAST_HIGHLIGHT_STYLES[commandseparator]='fg=#F5BDE6'
      FAST_HIGHLIGHT_STYLES[hashed-command]='fg=#A6DA95'
      FAST_HIGHLIGHT_STYLES[path]='fg=#8AADF4,underline'
      FAST_HIGHLIGHT_STYLES[path-to-dir]='fg=#8AADF4,underline'
      FAST_HIGHLIGHT_STYLES[path_pathseparator]='fg=#8AADF4,underline'
      FAST_HIGHLIGHT_STYLES[globbing]='fg=#8AADF4'
      FAST_HIGHLIGHT_STYLES[history-expansion]='fg=#C6A0F6'
      FAST_HIGHLIGHT_STYLES[single-hyphen-option]='fg=#EED49F'
      FAST_HIGHLIGHT_STYLES[double-hyphen-option]='fg=#EED49F'
      FAST_HIGHLIGHT_STYLES[back-quoted-argument]='fg=#C6A0F6'
      FAST_HIGHLIGHT_STYLES[single-quoted-argument]='fg=#EED49F'
      FAST_HIGHLIGHT_STYLES[double-quoted-argument]='fg=#EED49F'
      FAST_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=#8AADF4'
      FAST_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=#8AADF4'
      FAST_HIGHLIGHT_STYLES[assign]='fg=#C6A0F6'
      FAST_HIGHLIGHT_STYLES[redirection]='fg=#F5BDE6'
      FAST_HIGHLIGHT_STYLES[comment]='fg=#5B6078'
      FAST_HIGHLIGHT_STYLES[variable]='fg=#8AADF4'
      FAST_HIGHLIGHT_STYLES[math]='fg=#F5A97F'
      FAST_HIGHLIGHT_STYLES[forloop]='fg=#C6A0F6'
      FAST_HIGHLIGHT_STYLES[forarg]='fg=#C6A0F6'
      FAST_HIGHLIGHT_STYLES[bracket-level-1]='fg=#8AADF4'
      FAST_HIGHLIGHT_STYLES[bracket-level-2]='fg=#A6DA95'
      FAST_HIGHLIGHT_STYLES[bracket-level-3]='fg=#EED49F'


      unsetopt nomatch
    '';

    shellAliases = {
      q = "exit";
      c = "clear";
      ff = "fastfetch";
      z = "zellij";
      y = "yazi";
      lg = "lazygit";

      flakeUpdate = "nix flake update --flake /home/jayden/.dotfiles";
      rebuildSwitch = "sudo nixos-rebuild switch --flake /home/jayden/.dotfiles#${hostname}";
      homeSwitch = "home-manager switch --flake /home/jayden/.dotfiles#jayden@${hostname}";
    };
  };


  # ----- fastfetch -----
  programs.fastfetch = {
    enable = true;
    settings = {
      modules = [
        "title"
        "separator"
        "os"
        "host"
        "kernel"
        "uptime"
        "separator"
        "de"
        "wm"
        "shell"
        "separator"
        "cpu"
        "gpu"
        "disk"
        "memory"
        "swap"
        "break"
        "colors"
        ];
    };
  };


  # ----- atuin -----
  programs.atuin = {
    enable = false;
    enableZshIntegration = true;

    settings = {
      # Inline history search (up arrow still works normally)
      inline_height = 10;

      # Show preview of command
      show_preview = true;

      # Use Ctrl-R for atuin search (up arrow still normal)
      keymap_mode = "auto";

      # Style to match our theme
      style = "compact";

      # Sync is optional - set to false if you don't want cloud sync
      auto_sync = false;
      sync_address = "";

      # Search settings
      search_mode = "fuzzy";
      filter_mode = "global";

      # Better filtering
      workspaces = false;
    };
  };


  # ----- nvim -----
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = false;
    vimAlias = false;

    plugins = with pkgs.vimPlugins; [
      catppuccin-nvim
      vim-airline
      vim-airline-themes
    ];

    extraConfig = ''
      colorscheme catppuccin-macchiato
      let g:airline_theme = 'catppuccin'
    '';
  };


  # ----- git -----
  programs.git = {
    enable = true;
    settings = {
      user.name = "pinkmanners";
      user.email = "inbox@pinkmanners.cc";
      init.defaultBranch = "main";
    };
  };

  programs.delta = {
    enable = true;
  };


  # ----- catppuccin -----
  catppuccin = {
    enable = true;
    flavor = "macchiato";
    accent = "mauve";

    # make sure these apply (some don't tho lol)
    zed.enable = true;
    zellij.enable = true;
    yazi.enable = true;
    nvim.enable = true;
    lazygit.enable = true;
    kvantum.enable = true;
    kvantum.apply = true;
    fzf.enable = true;
    freetube.enable = true;
    delta.enable = true;
    cava.enable = true;
    btop.enable = true;
    brave.enable = true;
    bottom.enable = true;
    bat.enable = true;
    atuin.enable = true;
    alacritty.enable = true;

    hyprlock.enable = lib.mkForce false;
    hyprland.enable = lib.mkForce false;
    gtk.icon.enable = lib.mkForce false;
  };


  # ----- gtk -----
  gtk = {
    enable = true;

    theme = {
        name = lib.mkDefault "Catppuccin-Mauve-Dark-Macchiato";
        package = lib.mkDefault pkgs.catppuccin-gtk-theme;
    };

    iconTheme = {
      name = lib.mkDefault "Flatery-Red-Dark";
      package = lib.mkDefault pkgs.flatery-icon-theme;
    };

    cursorTheme = {
      name = "Mocu-White-Right-H";
      package = pkgs.mocu-cursor-theme;
      size = 32;
    };

    font = {
      name = "Space Grotesk Regular";
      size = 12;
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };


  # ----- qt -----

  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style.name = "kvantum";
  };


  # ----- xdg -----

  # create my dev folder first
  home.file."Development/.wolf".text = "bark bark";

  xdg = {
    enable = true;

    userDirs = {
      enable = true;
      createDirectories = true;
      documents = "${config.home.homeDirectory}/Documents";
      download = "${config.home.homeDirectory}/Downloads";
      music = "${config.home.homeDirectory}/Music";
      pictures = "${config.home.homeDirectory}/Pictures";
      videos = "${config.home.homeDirectory}/Videos";

      desktop = null;
      publicShare = null;
      templates = null;
    };
  };


  # ----- shared programs -----
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    # overlay packages
    mocu-cursor-theme
    space-grotesk-font
    flatery-icon-theme
    catppuccin-gtk-theme

    # audio/music
    pavucontrol
    kdePackages.elisa
    tenacity
    #audacity

    # video/media players
    vlc

    # image viewers/editors
    kdePackages.gwenview
    gimp

    # file Management/utilities
    xarchiver
    xfce.catfish
    gparted
    kdePackages.partitionmanager

    # text/code editors
    kdePackages.kate
    kdePackages.ghostwriter

    # document viewers/office
    kdePackages.okular
    libreoffice-fresh

    # internet/network
    mullvad-vpn
    mullvad-browser
    transmission_4-qt

    # theming/Qt configuration
    libsForQt5.qtstyleplugin-kvantum
    kdePackages.qtstyleplugin-kvantum
    libsForQt5.qt5ct
    kdePackages.qt6ct
    catppuccin-qt5ct

    # font
    font-util
  ];
}
