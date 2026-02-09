{ config, ... }:
{
  homeHosts.horizon = {
	  unstable = true;
	  
	  modules = with config.flake.modules.homeManager; [
      desktop
      ssh-github
	  ];
  };
}
