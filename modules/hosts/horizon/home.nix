{ config, ... }:
{
  homeHosts.horizon = {
	  unstable = true;
	  
	  modules = [
		  {
        imports = with config.flake.modules.homeManager; [
          desktop
        ];
			}
	  ];
  };
}
