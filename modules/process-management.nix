{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        btop # Monitor of resources
        glances # Cross-platform curses-based monitoring tool
        procs # Modern replacement for ps written in Rust
        sysz # Fzf terminal UI for systemctl
        watchexec # Executes commands in response to file modifications

        # TODO: Do we need this?
        lsof
        # TODO: Do we need this?
        psmisc
      ];

      programs.bottom = {
        enable = true;
        settings = {
          rate = 400;
        };
      };
    };
}
