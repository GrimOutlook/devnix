{
  nixConfig = {
    abort-on-warn = true;
    extra-experimental-features = [ "pipe-operators" ];
    allow-import-from-derivation = false;
  };

  inputs = {
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    # Seamless integration of git hooks with Nix
    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs = {
        flake-compat.follows = "dedupe_flake-compat";
        nixpkgs.follows = "nixpkgs";
      };
    };

    import-tree.url = "github:vic/import-tree";

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };


    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
      };
    };

    # Jump to next/previous LSP reference in the current buffer for the item
    # under the cursor with `]r`/`[r`.
    refjump-nvim = {
      flake = false;
      url = "github:mawkler/refjump.nvim";
    };

    # Smart scroll is a plugin that enables you to control the scrolloff
    # setting using percentages instead of static line numbers. This is a more
    # intuitive way to handle scrolling, especially as you move between
    # laptops, monitors, and resized windows and font sizes. Smart scrolloff
    # will always keep your scrolling experience consistent.
    smart-scrolloff-nvim = {
      flake = false;
      url = "github:tonymajestro/smart-scrolloff.nvim";
    };
  };

  # _additional_ `inputs` only for deduplication
  inputs = {
    dedupe_flake-compat.url = "github:edolstra/flake-compat";
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      text.readme.parts = {
        disallow-warnings =
          # markdown
          ''
            ## Trying to disallow warnings

            This at the top level of the `flake.nix` file:

            ```nix
            nixConfig.abort-on-warn = true;
            ```

            > [!NOTE]
            > It does not currently catch all warnings Nix can produce, but perhaps only evaluation warnings.
          '';

        flake-inputs-dedupe-prefix =
          # markdown
          ''
            ## Flake inputs for deduplication are prefixed

            Some explicit flake inputs exist solely for the purpose of deduplication.
            They are the target of at least one `<input>.inputs.<input>.follows`.
            But what if in the future all of those targeting `follows` are removed?
            Ideally, Nix would detect that and warn.
            Until that feature is available those inputs are prefixed with `dedupe_`
            and placed in an additional separate `inputs` attribute literal
            for easy identification.

          '';

        automatic-import =
          # markdown
          ''
            ## Automatic import

            Nix files (they're all flake-parts modules) are automatically imported.
            Nix files prefixed with an underscore are ignored.
            No literal path imports are used.
            This means files can be moved around and nested in directories freely.

            > [!NOTE]
            > This pattern has been the inspiration of [an auto-imports library, import-tree](https://github.com/vic/import-tree).

          '';
      };

      imports = [ (inputs.import-tree ./modules) ];

      _module.args.rootPath = ./.;
    };
}
