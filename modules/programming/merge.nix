{config, lib, pkgs, ...}:
{
  flake.modules =
    {
    nixos.base.programs = {
      git.config = {
        merge ={
          conflictstyle = "zdiff3";
          tool = "diffview";
        };

        mergetool = {
          prompt = false;
          keepBackup = false;
          "diffview" = {
            cmd = ''nvim -n -c 'DiffviewOpen' "$MERGE"'';
            layout = "LOCAL,BASE,REMOTE / MERGED";
          };
        };
      };
    };

    homeManager.gui = {
      home.packages = with pkgs; [
        meld # Visual diff and merge tool
      ];
    };
  };
}
