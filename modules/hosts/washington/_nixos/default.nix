{
  modulesPath,
  lib,
  pkgs,
  ...
} @ args:
{
  imports = [
    ./hardware.nix
  ];

  environment.systemPackages = map lib.lowPrio [
    pkgs.curl
    pkgs.gitMinimal
  ];

  services.openssh.enable = true;
  users.users = {
    root.openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBshpqm8SogcHSuol7cFNLi9R+WJR8XoWXpM6gmxLWb1 grim@horizon"
    ];
    grim.openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBshpqm8SogcHSuol7cFNLi9R+WJR8XoWXpM6gmxLWb1 grim@horizon"
    ];
  };
  system = {
    autoUpgrade.enable = true;
    stateVersion = "25.05";
  };
}
