{config, ...}:
{
  flake.modules.nixos.base = 
    {pkgs, ...}:
    {
      environment.systemPackages = with pkgs; [
        dotnet-sdk
        dotnet-runtime
        dotnetPackages.Nuget
      ];

      programs.nixvim = {
        lsp.servers = {
          csharp_ls.enable = true;
        };
        plugins = {
          treesitter = {
            grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
              c_sharp
            ];
          };
        };
      };
    };
}
