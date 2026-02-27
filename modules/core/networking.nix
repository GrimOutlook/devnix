{
  flake.modules.nixos.core = {
    networking = {
      networkmanager.enable = true;
      nftables.enable = true;
      firewall = {
        enable = true;
        logRefusedConnections = true;
      };
    };
  };
}
