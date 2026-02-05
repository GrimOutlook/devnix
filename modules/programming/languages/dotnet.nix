{
  flake.modules.homeManager.base = 
    {pkgs, ...}:
    {
      home.packages = with pkgs; [
        dotnet-sdk
        dotnet-runtime
        pkgs.dotnetPackages.Nuget
      ];
    };
}
