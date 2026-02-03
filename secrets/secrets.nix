let
  home_laptop_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGKioB5C0OpoFNFHKEaKFGcaI50070Q/NvYUM0SMgxVP";
  keys = [home_laptop_key];
in {
  "github.com.age".publicKeys = keys;
}
