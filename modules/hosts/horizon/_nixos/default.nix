{config, inputs, lib, self, ...}:
{
  age.rekey.hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGKioB5C0OpoFNFHKEaKFGcaI50070Q/NvYUM0SMgxVP";
  
  system = {
    autoUpgrade.enable = false;
    stateVersion = "25.05";
  };
}
