{ config, ... }:
{
  flake.modules.homeManager.base = args: {
    home = {
      username = config.flake.meta.owner.username;
      homeDirectory = "/home/${config.flake.meta.owner.username}";
    };
    programs.home-manager.enable = true;

    # Ensures that user-level systemd services are properly started, stopped,
    # or reloaded during the activation of a new Home Manager configuration
    systemd.user.startServices = "sd-switch";
  };
}
