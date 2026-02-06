{ config, ... }:
{
  configurations.nixos.horizon.module = {
    imports = with config.flake.modules.nixos; [
      wsl
      grim
    ];
    networking.domain = "local";
    networking.hostName = "horizon";
    facter.reportPath = ./facter.json;
    system.stateVersion = "25.11";
  };
}
