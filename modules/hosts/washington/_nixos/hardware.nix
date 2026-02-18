{
  lib,
  modulesPath,
  pkgs,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./disko.nix
  ];

  # hardware.facter.reportPath = ./facter.json;

  boot = {
    # Use latest linux kernel
    kernelPackages = pkgs.linuxPackages_latest;

    loader = {
      efi.efiSysMountPoint = "/boot";

      grub = {
        # no need to set devices, disko will add all devices that have a EF02
        # partition to the list already
        # devices = [ ];
        efiSupport = true;
      };
    };
  };

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
