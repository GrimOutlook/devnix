topLevel: {
  flake.modules.homeManager.dev =
    { ... }:
    {
      imports = with topLevel.config.flake.modules.homeManager; [
        git
        nixvim
      ];
    };
}
