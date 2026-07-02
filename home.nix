{
  hostName,
  config,
  pkgs,
  lib,
  ...
}: {
  imports =
    [
      ./programs/zed-editor.nix
      ./programs/zsh.nix
      ./programs/nh.nix
      ./programs/autojump.nix
      ./programs/direnv.nix

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
    fzf
    htop
    httpie
    jq
    ripgrep
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
    swayidle
    swaylock-effects
    wbg
    wdisplays
    wl-clipboard
    wlr-randr

    # Browser
    google-chrome

    # Development
    bun
    go
    nixfmt
    python3
    uv

    # Kubernetes
    kubectl
    kubectl-view-secret
    kubectx
    kubernetes-helm

    # Cloud
    google-cloud-sdk

    # IDE
    jetbrains.idea

    # Communication
    slack

    # Password manager
    enpass
  ];

  home.file.".config" = {
    source = ./dotfiles/.config;
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
