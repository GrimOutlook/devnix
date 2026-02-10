{ config, ... }:
{
  homeHosts.horizon = {
    unstable = true;
    modules = with config.flake.modules.homeManager; [
      dev
      ssh-github
    ];
  };
}
