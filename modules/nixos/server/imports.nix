{ config, ... }:
{
  flake.modules.nixos.server = 
    {pkgs, ...}:
    {
      imports = with config.flake.modules.nixos; [
      ];

      environment.systemPackages = with pkgs; [
        podman
      ];
    };
}
