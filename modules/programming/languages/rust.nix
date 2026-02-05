{
  flake.modules.nixos.base.programs.nixvim = 
    {pkgs, ...}:
    {
    plugins = {
      crates.enable = true;
      rustaceanvim.enable = true;

      treesitter = {
        grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          nix
        ];
      };
    };
  };
}
