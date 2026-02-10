{
  flake.modules.homeManager.core =
    {
      pkgs,
      config,
      ...
    }:
    {
      home = {
        packages = with pkgs; [
          dotnet-sdk_9
          dotnet-runtime_9
          dotnetPackages.Nuget
        ];
      };

      programs = {
        nixvim = {
          lsp.servers = {
            csharp_ls.enable = true;
          };
        };
      };
    };
}
