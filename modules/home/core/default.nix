{config, lib, ...}:
let
  username = config.meta.owner.username;
in
{
  flake.modules.homeManager.core =
    {
      lib,
      pkgs,
      config,
      ...
    }:
    {
      home = {
        username = "${username}";
        homeDirectory = lib.mkForce "/${if pkgs.stdenv.isLinux then "home" else "Users"}/${username}";
      };
    };
}
