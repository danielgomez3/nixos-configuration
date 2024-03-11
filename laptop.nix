# laptop.nix
# NOTE: This contains all common features I want only my laptop to have!

{ config, pkgs, lib, inputs, modulesPath, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./configuration.nix
      inputs.home-manager.nixosModules.default
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

 # NOTE: Unique configuration.nix content for desktop:
  networking.hostName = "laptop"; # Define your hostname.
  home-manager = { 
    extraSpecialArgs = { inherit inputs; };
    users.daniel = {
    };
  };
  networking.firewall.enable = true;

  services.xserver = {
   # enable = true;
   xkb.options = "caps:swapescape";
  };


  # NOTE: Unique home-manager config for laptop:


  # NOTE: Unique hardware-configuration.nix content for laptop:
  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" "sdhci_pci" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/8a06ac45-ec12-4b65-9b4e-aad7b200e5ac";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/4943-1681";
      fsType = "vfat";
    };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp3s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp2s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

 
}
