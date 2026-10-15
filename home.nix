{
  hostName,
  config,
  pkgs,
  lib,
  ...
}: let
  gdk = pkgs.google-cloud-sdk.withExtraComponents (with pkgs.google-cloud-sdk.components; [
    gke-gcloud-auth-plugin
  ]);
in {
  imports =
    [
      ./programs/zed-editor.nix
      ./programs/zsh.nix
      ./programs/nh.nix
      ./programs/autojump.nix
      ./programs/direnv.nix
      ./programs/fzf.nix

      ./services/mako.nix
    ]
    ++ lib.optionals (hostName == "dm") [
      ./services/kanshi.nix
    ];

  home.username = "dmitry";

  programs.home-manager.enable = true;
  programs.git.enable = true;
  programs.zsh.enable = true;
  programs.firefox.enable = true;

  home.packages = with pkgs; [
    pavucontrol
    pamixer

    sox
    # CLI utilities
    bat
    bc
    croc
    dive
    eza
    fd
    gcc
    handlr-regex
    htop
    httpie
    jq
    libxml2
    pnpm
    rclone
    ripgrep
    stern
    tfenv
    tomlq
    tree
    wrangler
    yq
    talosctl
    sonobuoy

    # Terminal
    alacritty

    # File manager
    thunar

    # Wayland / Sway
    grim
    slurp
    swappy
    swaycwd
    swayidle
    swaylock-effects
    tofi
    wbg
    wdisplays
    wl-clipboard
    wlr-randr

    # Browser
    google-chrome

    # Development
    bun
    gnumake
    go
    zlib
    stdenv.cc.cc.lib
    libpulseaudio
    (lua.withPackages (ps: [ps.cjson]))
    nixfmt
    nodejs
    perl
    perl5Packages.Carton
    python3
    uv
    rustc
    cargo
    rust-analyzer

    # Kubernetes
    kubectl
    kubectl-view-secret
    kubectx
    krew
    kubernetes-helm

    # Cloud
    gdk

    # IDE
    jetbrains.idea

    # Communication
    slack
    telegram-desktop

    # Password manager
    enpass
  ];

  home.sessionVariables = {
    TFENV_CONFIG_DIR = "$HOME/.tfenv";
    SDL_AUDIODRIVER = "pulseaudio";
    LD_LIBRARY_PATH = "${pkgs.lib.makeLibraryPath (with pkgs; [
      stdenv.cc.cc.lib
      zlib
      glib
      libpulseaudio
    ])}";
  };

  home.file.".config" = {
    source = ./dotfiles/.config;
    recursive = true;
  };

  home.file."bin" = {
    source = ./dotfiles/bin;
    recursive = true;
  };

  programs.waybar.enable = true;

  gtk = {
    enable = true;

    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };

    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  home.stateVersion = "26.05";
}
