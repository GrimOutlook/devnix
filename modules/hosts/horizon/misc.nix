{
  flake.modules.nixos.host_horizon =
    { pkgs, ... }:
    {
      system = {
        autoUpgrade.enable = false;

        stateVersion = "25.05";
      };
    };
}
