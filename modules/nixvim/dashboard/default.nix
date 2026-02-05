{ inputs, lib, config, ... }:
{
  flake.modules.nixos.base.programs.nixvim = 
    {pkgs, ...}:
    {
      dependencies = {
        # Used to pixelate a PNG for display in Neovim
        chafa.enable = true;
      };

      plugins.snacks.settings.dashboard = 
        let
          thisisfine = ./thisisfine.txt;
        in
        {
          sections = [
            {
              header = ''
                            )  (    (      (    (      (     (        )
                  *   )  ( /(  )\ ) )\ )   )\ ) )\ )   )\ )  )\ )  ( /(
                ` )  /(  )\())(()/((()/(  (()/((()/(  (()/( (()/(  )\()) (
                 ( )(_))((_)\  /(_))/(_))  /(_))/(_))  /(_)) /(_))((_)\  )\
                (_(_())  _((_)(_)) (_))   (_)) (_))   (_))_|(_))   _((_)((_)
                |_   _| | || ||_ _|/ __|  |_ _|/ __|  | |_  |_ _| | \| || __|
                  | |   | __ | | | \__ \   | | \__ \  | __|  | |  | .` || _|
                  |_|   |_||_||___||___/  |___||___/  |_|   |___| |_|\_||___|
              '';
            }
            {
              section = "terminal";
              cmd = "${pkgs.coreutils-full}/bin/cat ~/.config/nvim/resources/wall.output; sleep 0.1";
              padding = 1;
              height = 30;
            }
          ];
        };
    };
}
