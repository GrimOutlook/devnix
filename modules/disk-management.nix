{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        duf # Disk Usage/Free Utility
        dust # du, but more intuitive
        fclones # Efficient Duplicate File Finder and Remover
      ];
    };
}
