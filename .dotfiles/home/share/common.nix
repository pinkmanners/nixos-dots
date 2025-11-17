{ config, pkgs, lib, hostname, ... }:

{
  # ----- home stuffs -----
  home.username = "jayden";
  home.homeDirectory = "/home/jayden";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfree = true;


  # ----- zsh -----
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
      # Enable hyphen-insensitive completion
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*'

      # Set completion waiting dots
      expand-or-complete-with-dots() {
        echo -n "%F{red} ...sit and wait like a good girl ^_^ %f"
        zle expand-or-complete
        zle redisplay
      }
      zle -N expand-or-complete-with-dots
      bindkey "^I" expand-or-complete-with-dots

      autoload -Uz compinit
      compinit
    '';

    # env vars
    sessionVariables = {
      EDITOR = "nvim";
      LANG = "en_US.UTF-8";
      QT_QPA_PLATFORMTHEME = "kvantum";
      QT_STYLE_OVERRIDE = "kvantum";
    };

    # zinit + plugins
    initExtra = ''
      # ===== ZINIT SETUP =====
      # Install zinit if not present
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
      zinit snippet OMZP::git
      zinit ice wait lucid
      zinit snippet OMZP::nix-shell


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

      # ===== STARSHIP TRANSIENT PROMPT =====
      # Enable transient prompt for cleaner history
      function starship_transient_prompt_func() {
        starship module character
      }

      # Enable Starship's transient prompt
      export STARSHIP_TRANSIENT_PROMPT=1

      # ===== CUSTOM SETTINGS =====
      unsetopt nomatch

      # Run fastfetch on shell start
      fastfetch
    '';

    # Shell aliases
    shellAliases = {
      # Navigation
      cd.. = "cd ..";

      # List with lsd
      lsd = "lsd -al";

      # Quick commands
      q = "exit";
      c = "clear";

      # NixOS specific
      flakeUpdate = "nix flake update";
      rebuildSwitch = "sudo nixos-rebuild switch --flake /home/jayden/.dotfiles/#L14";
      homeSwitch = "home-manager switch --flake /home/jayden/.dotfiles/#jayden@L14";
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
        "packages"
        "shell"
        "display"
        "de"
        "wm"
        "terminal"
        "terminalfont"
        "cpu"
        "gpu"
        "memory"
        "swap"
        "disk"
        "localip"
        "break"
        "colors"
        ];
    }
  };


  # ----- starship -----
  programs.starship = {
    enable = true;
    settings = {
      # Add a blank line at the start of the prompt
      add_newline = true;

      # Format: display modules in this order
      format = lib.concatStrings [
        "$directory"
        "$git_branch"
        "$git_status"
        "$line_break"
        "$character"
      ];

      # Right prompt with execution time
      right_format = "$cmd_duration";

      directory = {
        style = "bold blue";
        format = "[$path]($style)";
        truncation_length = 100;
        truncate_to_repo = false;
      };

      git_branch = {
        style = "grey";
        format = " [$branch]($style)";
      };

      git_status = {
        style = "cyan";
        format = "([$all_status$ahead_behind]($style))";
        conflicted = "";
        ahead = "⇡";
        behind = "⇣";
        diverged = "⇡⇣";
        untracked = "";
        stashed = "";
        modified = "*";
        staged = "*";
        renamed = "";
        deleted = "";
      };

      cmd_duration = {
        min_time = 5000;
        style = "yellow";
        format = "[$duration]($style)";
      };

      character = {
        success_symbol = "[❯](magenta)";
        error_symbol = "[❯](red)";
        vimcmd_symbol = "[❯❯](magenta)";
      };
    };
  };


  # ----- nvim -----
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

    extraConfig = ''
      " Set colors to catppuccin
      colorscheme catppuccin-macchiato
      let g:airline_theme = 'catppuccin'
    '';
  };


  # ----- git -----
  programs.git = {
    enable = true;
    userName = "pinkmanners";
    userEmail = "inbox@pinkmanners.cc";
  };


  # ----- gtk -----
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
      name = "Mocu-White-Right-H";
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


  # ----- qt -----
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


  # ----- xdg -----
  xdg = {
    enable = true;

    userDirs = {
      enable = true;
      createDirectories = true;
      developer = "${config.home.homeDirectory}/Developer";
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
        "inode/directory" = "dolphin.desktop";
      };
    };
  };


  # ----- shared programs -----
  home.packages = with pkgs; [
    kdePackages.dolphin
    xarchiver

    zed-editor
    kdePackages.kate

    catfish
    gparted
    kdePackages.partitionmanager

    mullvad-vpn
    mullvad-browser

    kdePackages.elisa
    tenacity
    audacity
    vlc
    kdePackages.gwenview

    gimp

    kdePackages.kfontview
    kdePackages.okular

    bitwarden
    transmission_4-qt
    libreoffice-fresh
    ffmpeg

    libsForQt5.qtstyleplugin-kvantum
    kdePackages.qtstyleplugin-kvantum
    libsForQt5.qt5ct
    kdePackages.qt6ct
  ]
}
