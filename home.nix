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
    # CLI utilities
    bat
    bc
    eza
    fd
    gcc
    htop
    httpie
    jq
    ripgrep
    tfenv
    tree
    wrangler

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
    wbg
    wdisplays
    wl-clipboard
    wlr-randr

    # Browser
    google-chrome

    # Development
    gnumake
    bun
    go
    nixfmt
    python3
    uv
    lua
    perl
    perl5Packages.Carton

    # Kubernetes
    kubectl
    kubectl-view-secret
    kubectx
    kubernetes-helm

    # Cloud
    gdk

    # IDE
    jetbrains.idea

    # Communication
    slack

    # Password manager
    enpass
  ];

  home.sessionVariables = {
    TFENV_CONFIG_DIR = "$HOME/.tfenv";
  };

  home.file.".config" = {
    source = ./dotfiles/.config;
    recursive = true;
  };

  home.file."bin" = {
    source = ./dotfiles/bin;
    recursive = true;
  };

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
