{
  ...
}: {
  boot.initrd.availableKernelModules = [ "nvme" "ehci_pci" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ "dm-snapshot" "cryptd" ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];
}
