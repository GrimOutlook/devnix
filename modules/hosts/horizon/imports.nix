{ config, ... }:
{
  configurations.nixos.horizon.module = {
    imports = with config.flake.modules.nixos; [
      wsl
    ];
  };
}
