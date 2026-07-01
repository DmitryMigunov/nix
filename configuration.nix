{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 10;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 10d";
  };

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Riga";

  programs.zsh.enable = true;

  users.users.dmitry = {
    isNormalUser = true;
    extraGroups = ["wheel" "disk"];
    shell = pkgs.zsh;
  };

  environment.systemPackages = with pkgs; [
    wget
    curl
    git
    gparted-full
    wl-clipboard
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  environment.shellAliases = {
    vim = "nvim";
  };

  fonts = {
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      noto-fonts
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = ["JetBrainsMono Nerd Font Mono"];
        serif = ["Noto Serif"];
        sansSerif = ["Noto Sans"];
      };
    };
  };

  services.greetd = {
    enable = true;

    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --cmd sway --time --remember";
        user = "greeter";
      };
    };
  };

  services.gnome.gnome-keyring.enable = true;

  services.udisks2.enable = true;
  services.gvfs.enable = true;

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  security.polkit.enable = true;

  system.stateVersion = "26.05";
}
