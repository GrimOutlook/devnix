{ config, ... }:
{
  nixosHosts.horizon = {
    unstable = true;

    modules = [
      ./_nixos
    ]
    ++ (with config.flake.modules.nixos; [
      dev
      wsl
    ]);
  };
}
