{
  flake.modules.nixos.base =
    {config, lib, pkgs, ...}:
    {
      environment.systemPackages = with pkgs; [
        difftastic
      ];

      environment.shellAliases = {
        diff = "difft";
      };

      programs = {
        git.config = {
          diff = {
            mnemonicprefix = true;
            algorithm = "patience";
            external = "difft";

            # Set difftastic as the default difftool, so we don't need to specify
            # `-t difftastic` every time.
            tool = "difftastic";
          };

          difftool = {
            # Run the difftool immediately, don't ask 'are you sure' each time.
            prompt = false;
          };

          pager = {
            # Use a pager if the difftool output is larger than one screenful,
            # consistent with the behaviour of `git diff`.
            difftool = true;
          };
        };
      };
  };
}
