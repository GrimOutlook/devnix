{
  flake.modules.nixos.ssh-server = {
    services.openssh = {
      enable = true;

      # Don't allow PasswordAuthentication to SSH hosts EVER.
      settings.PasswordAuthentication = false;
    };

    users.users =
      let
        # FIXME: Change to  a valid key
        key = "ssh-ed25519 CHANGEME";
      in
      {
        root.openssh.authorizedKeys.keys = [ key ];
      };
  };
}
