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
			  rage
        ragenix
      ];

      age = {
			  rekey = {
          storageMode = "local";
          masterIdentities = [
					  { 
						  identity = ../../../secrets/nixos/master-key.age;
							pubkey = "age153pk74f0camdefccx0cc3mkxd4mlkjt4ladavtcmzkj07ynwreqqv9twhf";
						}
					];
          localStorageDir = ../../../secrets/${config.networking.hostName}/nixos;
        };
			};
    };
}
