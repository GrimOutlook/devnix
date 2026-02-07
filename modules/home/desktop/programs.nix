{
  flake.modules.homeManager.desktop-programs =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        # IM
        discord
        signal-desktop

        # Misc
        spotify
      ];
    };
}
