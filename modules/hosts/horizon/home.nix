{ config, ... }:
{
  homeHosts.horizon = {
    unstable = true;
    modules = with config.flake.modules.homeManager; [
      dev
      ssh-github
      {
        programs.ssh.matchBlocks = {
          Brussels = {
            hostname = "brussels.home.arpa";
            user = "root";
          };
          Washington = {
            hostname = "washington.home.arpa";
            user = "grim";
          };
        };
      }
    ];
  };
}
