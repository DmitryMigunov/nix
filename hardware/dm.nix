{...}: {
  boot.initrd.availableKernelModules = ["nvme" "ehci_pci" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod"];
  boot.initrd.kernelModules = ["dm-snapshot" "cryptd"];
  boot.kernelModules = ["kvm-intel"];
  boot.extraModulePackages = [];

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  services.blueman.enable = true;

  services.pipewire = {
      enable = true;
      pulse.enable = true;
    };
}
