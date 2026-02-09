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
        masterIdentities = [ ../../../secrets/master-key.age ];
        localStorageDir = ../../../secrets/home/${configName};
      };
    };
}
