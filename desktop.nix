# desktop.nix
# NOTE: This contains all common features I want only my desktop to have!

{ config, pkgs, lib, inputs, modulesPath, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./configuration.nix
      inputs.home-manager.nixosModules.default
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  # NOTE: Unique configuration.nix content for desktop:
  networking.hostName = "desktop"; # Define your hostname.
  services.xserver = {
    xkb.options = "";
  };

  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "daniel" ];
  virtualisation.virtualbox.host.enableExtensionPack = true;  
  virtualisation = {
    docker = {
      enable = true;
    }; 
  };

  # NOTE: Unique home-manager config for desktop:
  home-manager = { 
    extraSpecialArgs = { inherit inputs; };
    users.daniel = {
      obs-studio = {
        enable = true;
      };
    };
  };

  # NOTE: Unique hardware-configuration.nix content for laptop:
  # TODO:

}
