{config, ...}:
{
  flake.modules.nixos.base.programs.nixvim =
    {pkgs, ...}:
    {
    lsp.servers = {
      jdtls.enable = true;
    };
    plugins = {
      jdtls.enable = true;
      treesitter = {
        grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          java
        ];
      };
    };
  };
}
