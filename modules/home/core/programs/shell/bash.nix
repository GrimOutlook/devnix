{
  flake.modules.homeManager.core =
    {
      pkgs,
      lib,
      ...
    }:
    {
      programs.bash = {
        enable = true;

        initExtra = ''
          ${lib.getExe pkgs.pfetch}
        '';
      };
    };
}
