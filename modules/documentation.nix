{
  flake.modules.homeManager.base =
    {pkgs, ...}:
    {
      home.packages = with pkgs; [
        man # Implementation of the standard Unix documentation system accessed using the man command
        man-pages # Linux development manual pages
        # NOTE: This is installed so we can get all available man pages
        man-pages-posix # POSIX man-pages (0p, 1p, 3p)
        tealdeer # Very fast implementation of tldr in Rust
        wikiman # Offline search engine for manual pages, Arch Wiki, Gentoo Wiki and other documentation
      ];
      programs = {
         tealdeer = {
           enable = true;
           settings.display.use_pager = true;
         };
         info.enable = true;
      };
    };
}
