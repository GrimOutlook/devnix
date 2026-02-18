{ config, ... }:
let
  keys = "~/.ssh/keys";
in
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
            identityFile = "${keys}/brussels";
          };
          Washington = {
            hostname = "washington.home.arpa";
            user = "grim";
            identityFile = "${keys}/washington";
          };
        };
      }
    ];
  };
}
