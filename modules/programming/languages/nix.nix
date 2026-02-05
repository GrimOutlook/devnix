{pkgs, ...}:
{
  flake.modules.nixos.base.programs.nixvim =
    {pkgs, ...}:
    {
      lsp.servers = {
        statix.enable = true;
      };
      plugins = {
        nix.enable = true;
        treesitter = {
          grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
            nix
          ];
        };
      };
    };
}
