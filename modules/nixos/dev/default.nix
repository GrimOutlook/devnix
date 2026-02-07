topLevel: {
  flake.modules.nixos.dev =
    { config, ... }:
    {
      imports = with topLevel.config.flake.modules.nixos; [
        home-manager
        substituters
      ];

      # Enable nix-ld for easier uv use
      programs.nix-ld.enable = true;
    };
}
