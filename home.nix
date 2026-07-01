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

    enpass
    slack
    kubectl
    kubectx
    kubernetes-helm

    grim
    slurp
    swappy
    wl-clipboard

    jetbrains-toolbox

    wbg
    swaylock-effects
    swayidle
  ];

  home.file.".config" = {
    source = ./dotfiles/.config;
    recursive = true;
  };

  home.shellAliases = {
    c = "wl-copy";
    p = "wl-paste";
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
