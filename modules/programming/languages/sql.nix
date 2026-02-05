{
  flake.modules.nixos.base.programs.nixvim =
    {pkgs, ...}:
    {
    lsp.servers = {
      sqruff.enable = true;
    };
    plugins = {
      vim-dadbod.enable = true;
      treesitter = {
        grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          sql
        ];
      };
    };
  };
}
