{config, ...}:
{
  flake.modules.nixos.base =
    {pkgs, ...}: 
    {
      environment.systemPackages = with pkgs; [
        git # Distributed version control system
      ];

      programs.git = {
        enable = true;
        lfs.enable = true;
        prompt.enable = true;

        # Inspriations:
        # - [@waterkip](https://medium.com/@waterkip/my-git-workflow-7f2c145c9d6d)
        config = {
          core = {
            filemode = false;
            autocrlf = false;
            eol = "lf";

            # Treat spaces before tabs, and all kinds of trailing whitespace as an error
            whitespace = "space-before-tab,trailing-space";

            logAllRefUpdates = true;
            attributesFile = builtins.path { path = ./gitattributes; };
            excludesFile = builtins.path { path = ./gitignore; };
          };

          interactive = {
            diffFilter = "delta --color-only";
          };

          delta = {
            navigate = true;  # use n and N to move between diff sections
            dark = true;      # or light = true, or omit for auto-detection
          };

          init = {
            defaultBranch = "main";
          };

          push = {
            # Push the current branch to a branch of the same name on the remote.
            default = "current";
            autoSetupRemote = true;
          };

          pull = {
            # Avoid creating merge commits in non-main branches.
            rebase = true;
          };

          apply = {
            # Detect whitespace errors when applying a patch
            whitespace = "fix";
          };

          color = {
            "branch" = {
              current = "green";
              local   = "yellow";
              remote  = "yellow reverse";
            };

            "diff" = {
              meta = "yellow bold";
              frag = "magenta bold";
              old = "red bold";
              new = "green bold";
            };

            "status" = {
               added = "yellow";
               changed = "green";
               untracked = "cyan";
            };
          };

          remote = {
            pushDefault = "origin";
          };

          advice = {
            statusHints = false;
            detachedHead = false;
          };

          rebase = {
            autoStash = true;
            autosquash =  true;
            forkpoint = false;
          };

          clean = {
            requireForce = true;
          };

          user = {
            name = config.flake.meta.owner.name;
            email = config.flake.meta.owner.email;
          };
          
          commit = {
            template = builtins.path { path = ./commit-template; };
          };
        };
      };
    };
}
