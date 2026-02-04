{
  flake.modules.nixos.base.programs = {
    nixvim = {
      enable = true;
      vimAlias = true;
      defaultEditor = true;
    };
    nano.enable = false;
  };
}
