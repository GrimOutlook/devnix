{ config, ... }:
{
  flake = {
    modules = {
      nixos.base = {
        users.users.${config.flake.meta.owner.username} = {
          isNormalUser = true;
          initialPassword = "";
          extraGroups = [ "input" "sudo" "wheel" ];
        };

        nix.settings.trusted-users = [ config.flake.meta.owner.username ];
      };
    };
  };
}
