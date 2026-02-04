let
  home_laptop_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGKioB5C0OpoFNFHKEaKFGcaI50070Q/NvYUM0SMgxVP";
  home_desktop_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJZNqwWqgoIvHXT5bWO5wTvaeXEK40Ozc3dv53TON3+J";
  keys = [home_laptop_key home_desktop_key];
in {
  "github.com.age".publicKeys = keys;
}
