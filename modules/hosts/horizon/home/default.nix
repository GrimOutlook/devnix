{ config, ... }:
{
  flake.modules.homeManager.host_horizon = {
    imports = with config.flake.modules.homeManager; [
      desktop
    ];
  };
}
