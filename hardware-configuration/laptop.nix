{ config, lib, pkgs, modulesPath, ... }:
{
  boot.loader.grub.useOSProber = true;
  hardware.enableRedistributableFirmware = true;
  hardware.enableAllFirmware = true;

  microsoft-surface.kernelVersion = "6.1.18";

  boot.initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "nvme" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/c926bae1-6832-4ba9-a3d7-f5da11bfc846";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/5008-DA4A";
      fsType = "vfat";
    };

  swapDevices = [ ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  virtualisation.hypervGuest.enable = true;
}
