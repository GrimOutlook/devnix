{ config, inputs, ... }:
{
  flake.modules.nixos.core.imports = with config.flake.modules.nixos; [
    inputs.disko.nixosModules.disko

    agenix
    home-manager
    nix
    security
    ssh-server
    users
  ];
}
