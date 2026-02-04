{
  flake.modules.homeManager.base.programs = {
    tealdeer = {
      enable = true;
      settings.display.use_pager = true;
    };
    info.enable = true;
    # # TODO: Figure out how to add packages and add these packages
    # man # Implementation of the standard Unix documentation system accessed using the man command
    # man-pages # Linux development manual pages
    # # NOTE: This is installed so we can get all available man pages
    # man-pages-posix # POSIX man-pages (0p, 1p, 3p)
  };
}
