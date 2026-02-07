{
  flake.modules.nixos.host_horizon =
    {
      config,
      lib,
      modulesPath,
      pkgs,
      inputs,
      ...
    }:
    {
      imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
      ];

      boot = {
        # Use latest linux kernel
        kernelPackages = pkgs.linuxPackages_latest;
      };

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    };
}
