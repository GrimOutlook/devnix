{ inputs, lib, config, pkgs, ... }:

{
    imports = [
        # Include the nixvim modules
        inputs.nixvim.nixosModules.nixvim
    ];

    programs.nixvim = {
        enable = true;
        defaultEditor = true;
        viAlias = true;
        vimAlias = true;

        # Enable editorconfig plugin
        editorConfig.enable = true;

        # Enable the gruvbox colorscheme plugin
        colorschemes.gruvbox.enable = true;

        dependencies = {
            chafa.enable = true;
            tree-sitter.enable = true;
        };

        lsp.servers = {
            # Typos
            typos.enable = true;
            # Python
            ruff.enable = true;
            pyrefly.enable = true;
            bashls.enable = true;
            luasls.enable = true;
            jdtls.enable = true;
            gh_actions_ls.enable = true;
            docker_language_server.enable = true;
            ts_ls.enable = true;
            gitlab_ci_ls.enable = true;
            gradle_ls.enable = true;
            groovy_ls.enable = true;
            hyprls.enable = true;
            jqls.enable = true;
            just.enable = true;
            lemminx.enable = true;
            markdown_oxide.enable = true;
            powershell_es.enable = true;
            rpmspec.enable = true;
            stylelint_lsp.enable = true;
            systemd_lsp.enable = true;
            tailwindcss.enable = true;
            tombi.enable = true;
            yamlls.enable = true;
            svelte.enable = true;
            csharp_ls.enable = true;
            # SQL
            sqruff.enable = true;
        };

        plugins = {
            blink-cmp.enable = true;
            blink-cmp-git.enable = true;
            blink-emoji.enable = true;
            claude-code.enable = true;
            comment.enable = true;
            comment-box.enable = true;
            conform-nvim.enable = true;
            crates.enable = true;
            cursorline.enable = true;
            nvim-dbee.enable = true;
            dressing.enable = true;
            flash.enable = true;
            flit.enable = true;
            friendly-snippets.enable = true;
            fugitive.enable = true;
            git-conflict.enable = true;
            gitblame.enable = true;
            gitsigns.enable = true;
            grug-far.enable = true;
            guess-indent.enable = true;
            # TODO: Start from H
            
        }
    };
}
