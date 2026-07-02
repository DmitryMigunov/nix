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
    pkgs.nixfmt

    bc
    fzf
    eza
    htop
    alacritty
    ripgrep
    thunar
    wdisplays
    wlr-randr
    google-chrome
    tree
    bat
    jq
    httpie

    enpass
    slack
    kubectl
    kubectx
    kubernetes-helm
    kubectl-view-secret

    grim
    slurp
    swappy
    wl-clipboard

    jetbrains.idea
    google-cloud-sdk

    wbg
    swaylock-effects
    swayidle
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
