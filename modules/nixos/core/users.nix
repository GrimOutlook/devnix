{config, ...}:
let
  username = config.meta.owner.username;
in
{
  flake.modules.nixos.users = {
    users = {
      mutableUsers = false;

      users = {
        root = {
          isSystemUser = true;
        };

        "${username}" = {
          isNormalUser = true;
          uid = 1000;

          group = "${username}";

          initialPassword = "";
          
          extraGroups = [
            # Enable ‘sudo’ for the user.
            "sudo"
          ];
        };
      };
      groups."${username}" = {};
    };
    nix.settings.trusted-users = [ "${username}" ];
  };
}
