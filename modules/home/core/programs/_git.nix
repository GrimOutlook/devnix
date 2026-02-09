{
  flake.modules.homeManager.core = {
    programs = {
      git = {
        enable = true;

        settings = {
          user = {
            email = "dev@grimoutlook.dev";
            name = "Dominic Grimaldi";
          };

          core.editor = "nvim";
          github.user = "GrimOutlook";
          mergetool.prompt = false;
          pull.rebase = false;
        };
      };

      gh = {
        enable = true;

        settings = {
          git_protocol = "ssh";
        };
      };

      lazygit = {
        enable = true;
        settings = {
          gui = {
            theme = {
              activeBorderColor = [
                "blue"
                "bold"
              ];
              selectedLineBgColor = [ "white" ];
            };
          };
          git = {
            # Improves performance
            # https://github.com/jesseduffield/lazygit/issues/2875#issuecomment-1665376437
            log.order = "default";

            fetchAll = false;
          };
        };
      };
    };

    home.shellAliases = {
      lg = "lazygit";

      gs = "git switch";
      gsc = "git switch -c";
      gfu = "git fetch upstream";
      gfo = "git fetch origin";
      gpc = "gh pr checkout";
    };

    programs.fish.shellAbbrs = {
      B = "git checkout master || git checkout main && git pull && git checkout -b";
    };
  };
}
