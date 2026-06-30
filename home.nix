{
  config,
  pkgs,
  ...
}: let
  lock = "${pkgs.swaylock-effects}/bin/swaylock";
in {
  imports = [
    ./kanshi.nix
  ];

  home.username = "dmitry";

  programs.home-manager.enable = true;
  programs.git.enable = true;
  programs.zsh.enable = true;
  programs.firefox.enable = true;

  home.packages = with pkgs; [
    pkgs.nixfmt

    fzf
    htop
    alacritty
    ripgrep
    thunar
    wdisplays
    wlr-randr
    google-chrome

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
    awww
  ];

  home.file.".config/sway/config".source = ./configs/sway/config;

  home.shellAliases = {
    c = "wl-copy";
    p = "wl-paste";
  };

  services.mako = {
    enable = true;
    settings = {
      default-timeout = 5000;
    };
  };

  programs.zed-editor = {
    enable = true;
    extensions = ["nix" "toml" "rust"];
    userSettings = {
      theme = {
        mode = "system";
        dark = "One Dark";
        light = "One Light";
      };
      hour_format = "hour24";
    };
  };

  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;

    settings = {
      screenshots = true;
      effect-blur = "15x10";
      color = "00000099";
      indicator = true;
      clock = true;
      font-size = 28;
    };
  };

  services.swayidle = {
    enable = true;

    timeouts = [
      {
        timeout = 150;
        command = lock;
      }
      {
        timeout = 300;
        command = "${pkgs.sway}/bin/swaymsg 'output * dpms off'";
        resumeCommand = "${pkgs.sway}/bin/swaymsg 'output * dpms on'";
      }
    ];

    events = {
      "before-sleep" = lock;
      "after-resume" = "${pkgs.sway}/bin/swaymsg 'output * dpms on'";
    };
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
