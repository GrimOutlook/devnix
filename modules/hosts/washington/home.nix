{ config, ... }:
{
  homeHosts.washington = {
    unstable = true;
    modules = with config.flake.modules.homeManager; [
    ];
  };
}
