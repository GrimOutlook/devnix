{ config, ... }:
{
  host.washington = {
    nixos = {
      unstable = true;
      modules =
        [
          ./_nixos
        ]
        ++ (with config.flake.modules.nixos; [
          server
        ]);
    };
    home = {
      unstable = true;
      modules = with config.flake.modules.homeManager; [
      ];
    };
  };
}
