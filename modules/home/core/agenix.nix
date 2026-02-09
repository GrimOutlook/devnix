{ inputs, ... }:
{
  flake.modules.homeManager.agenix =
    { config, configName, ... }:
    {
      imports = [
        inputs.agenix.homeManagerModules.default
        inputs.agenix-rekey.homeManagerModules.default
      ];

      age.rekey = {
        storageMode = "local";
				masterIdentities = [
					{ 
						identity = ../../../secrets/nixos/master-key.age;
						pubkey = "age153pk74f0camdefccx0cc3mkxd4mlkjt4ladavtcmzkj07ynwreqqv9twhf";
					}
				];
        localStorageDir = ../../../secrets/${configName}/home;
      };
    };
}
