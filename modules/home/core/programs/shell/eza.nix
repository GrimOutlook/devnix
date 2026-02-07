{
  flake.modules.homeManager.core = {
    programs.eza = {
      enable = true;
      enableBashIntegration = false;
    };

    home.shellAliases = {
      ls = "eza";
      l = "eza -lhg";
      ll = "eza -alhg";
      lt = "eza --tree";
    };
  };
}
