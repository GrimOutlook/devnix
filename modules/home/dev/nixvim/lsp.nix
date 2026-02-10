{config, ...}:
{
  flake.modules.homeManager.dev.programs.nixvim = 
    {pkgs, ...}:
    {
      plugins.snacks = {
        enable = true;
        settings.picker.enable = true;
      };

      keymaps = [
        {
          mode = "n";
          key = "gd";
          action = "<cmd>lua Snacks.picker.lsp_definitions({current = false})<cr>";
          options = {
            desc = "Goto Definintion";
          };
        }
        {
          mode = "n";
          key = "gD";
          action = "<cmd>lua Snacks.picker.lsp_declarations({current = false})<cr>";
          options = {
            desc = "Goto Declaration";
          };
        }
        {
          mode = "n";
          key = "gr";
          action = "<cmd>lua Snacks.picker.lsp_references({current = false})<cr>";
          options = {
            desc = "Goto References";
          };
        }
        {
          mode = "n";
          key = "gI";
          action = "<cmd>lua Snacks.picker.lsp_implementations({current = false})<cr>";
          options = {
            desc = "Goto Implementations";
          };
        }
        {
          mode = "n";
          key = "gy";
          action = "<cmd>lua Snacks.picker.lsp_type_definitions({current = false})<cr>";
          options = {
            desc = "Goto T[y]pe Definitions";
          };
        }
      ];
    };
}
