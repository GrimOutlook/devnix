{ config, ... }:
{
  nixosHosts.washington = {
    unstable = true;

    modules = [
      ./_nixos
    ]
    ++ (with config.flake.modules.nixos; [
        server
    ]);
  };
}
