{ inputs, ... }:
{
  flake.modules.nixos.agenix =
    { config, pkgs, ... }:
    {
      imports = [
        inputs.agenix.nixosModules.default
        inputs.agenix-rekey.nixosModules.default
      ];

      environment.systemPackages = with pkgs; [
        ragenix
      ];

      age.rekey = {
        storageMode = "local";
        masterIdentities = [ ../../../secrets/master-key.age ];
        localStorageDir = ../../../secrets/nixos/${config.networking.hostName};
      };
    };
}
