{ config, ... }:
{
  flake.modules.homeManager.desktop.imports = with config.flake.modules.homeManager; [
    desktop-programs
    dunst
    rofi
    udiskie
    wayland
    zathura
  ];
}
