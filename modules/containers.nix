{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        ctop # Top-like interface for container metrics
        dive # Tool for exploring each layer in a docker image
        podman # Program for managing pods, containers and container images
      ];
      home.shellAliases = {
        docker = "podman";
      };
    };
}
