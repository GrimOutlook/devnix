{ config, ... }:
let
  keys = "~/.ssh/keys";
in
{
  host.taipei = {
    nixos = {
      unstable = true;
      modules =
        [
          ./_nixos
        ]
        ++ (with config.flake.modules.nixos; [
          dev
          wsl
        ]);
    };
    home = {
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
              user = "root";
              identityFile = "${keys}/washington";
            };
          };
        }
      ];
    };
  };
}
