{ config, ... }:
let
  inherit (config.flake.meta.accounts) github;
  forge = "github";
  owner = github.username;
  name = "devnix";
  defaultBranch = "main";
  flakeUri = "git+ssh:git@${github.domain}:${owner}/${name}";
in
{
  flake.meta.repo = {
    inherit
      forge
      owner
      name
      defaultBranch
      flakeUri
      ;
  };
}
