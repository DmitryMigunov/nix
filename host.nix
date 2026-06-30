{ hostName, ... }: {
  imports = [
    ./hardware/${hostName}.nix
  ];

  networking.hostName = hostName;
}
