
# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# The NixOS manual can be gound here: https://nixos.org/manual/nixos/stable/#sec-configuration-syntax

# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{ config, lib, pkgs, ... }:

let
  EZA_DEFAULT_OPTIONS="--header --long --time-style long-iso --git-repos --git --icons --octal-permissions --classify --hyperlink --group --mounts --extended";
in
{
  security.pki.certificateFiles = [
    ./certs/root-certs.pem
  ];
  
  # Enable the use of flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.systemPackages = with pkgs; [
    # NOTE: Required for nix flakes to work because flakes clones its dependencies through the git command
    git # Distributed version control system

    # NOTE: Required to import the certificate before building work computers
    cacert

    # -- General tools ---------------------------------------------------------
    bash
    bat # Cat(1) clone with syntax highlighting and Git integration
    btop # Monitor of resources
    choose # Human-friendly and fast alternative to cut and (sometimes) awk
    ctop # Top-like interface for container metrics
    curlie # Frontend to curl that adds the ease of use of httpie, without compromising on features and performance
    dive # Tool for exploring each layer in a docker image
    fd # Simple, fast and user-friendly alternative to find
    hexyl # Command-line hex viewer
    neovim # Vim text editor fork focused on extensibility and agility
    ripgrep # Utility that combines the usability of The Silver Searcher with the raw speed of grep
    sd # Intuitive find & replace CLI (sed alternative)
    starship # Minimal, blazing fast, and extremely customizable prompt for any shell
    tmux # Terminal multiplexer
    dust # du, but more intuitive
    duf # Disk Usage/Free Utility
    eza # Modern, maintained replacement for ls
    sad # CLI tool to search and replace
    zoxide # Fast cd command that learns your habits
    # TODO: Make an alias that kills processes using `skim` to search for a name
    skim # Command-line fuzzy finder written in Rust
    procs # Modern replacement for ps written in Rust
    hyperfine # Command-line benchmarking tool
    rip2 # Safe and ergonomic alternative to rm
    navi # Interactive cheatsheet tool for the command-line and application launchers
    broot # Interactive tree view, a fuzzy search, a balanced BFS descent and customizable commands
    fclones # Efficient Duplicate File Finder and Remover
    jq # Command-line JSON processor
    htmlq # Like jq, but for HTML.
    rage # A simple, secure and modern file encryption tool (and Rust library) with small explicit keys, no config options, and UNIX-style composability.
    glances # Cross-platform curses-based monitoring tool
    lnav # Logfile Navigator
    imagemagick # Software suite to create, edit, compose, or convert bitmap images
    irssi # Terminal based IRC client
    man # Implementation of the standard Unix documentation system accessed using the man command
    man-pages # Linux development manual pages
    man-pages-posix # POSIX man-pages (0p, 1p, 3p)
    # NOTE: This is installed so we can get all available man pages
    coreutils-full # GNU Core Utilities
    progress # Tool that shows the progress of coreutils programs
    # TODO: Make `ssh` command tell you to use `mosh`
    mosh # Mobile shell (ssh replacement)
    micro # Modern and intuitive terminal-based text editor
    neofetch # Fast, highly customizable system info script
    bingrep # Greps through binaries from various OSs and architectures, and colors them
    pandoc # Conversion between documentation formats
    plocate # Much faster locate
    podman # Program for managing pods, containers and container images
    rclone # Command line program to sync files and directories to and from major cloud storage
    rsync # Fast incremental file transfer utility
    sysz # Fzf terminal UI for systemctl
    tealdeer # Very fast implementation of tldr in Rust
    wikiman # Offline search engine for manual pages, Arch Wiki, Gentoo Wiki and other documentation
    xcp # Extended cp(1)
    watchexec # Executes commands in response to file modifications
    pastel # Command-line tool to generate, analyze, convert and manipulate colors
    ouch # Command-line utility for easily compressing and decompressing files and directories
    gnupg # Modern release of the GNU Privacy Guard, a GPL OpenPGP implementation

    # -- Nix tools -------------------------------------------------------------
    nix-index
    nix-ld

    # -- Networking ------------------------------------------------------------
    geoip # API for GeoIP/Geolocation databases
    netscanner # Network scanner with features like WiFi scanning, packetdump and more
    ngrep # Network packet analyzer
    rustcat # Port listener and reverse shell
    # TODO: Make an alias that redirects `nmap` to `rustscan`
    rustscan # Faster Nmap Scanning with Rust
    gping # Ping, but with a graph
    # TODO: Make `dig` an alias to `dog`
    dogdns # Command-line DNS client

    # -- Programming -----------------------------------------------------------
    tokei # Count your code, quickly
    git-filter-repo # Quickly rewrite git repository history
    pnpm # Fast, disk space efficient package manager for JavaScript
    just # Handy way to save and run project-specific commands
    dos2unix # Convert text files with DOS or Mac line breaks to Unix line breaks and vice versa
    cmake # Cross-platform, open-source build system generator
    gh # GitHub CLI tool
    delta # Syntax-highlighting pager for git
    jujutsu # Git-compatible DVCS that is both simple and powerful
    mdbook # Create books from MarkDown
    ripsecrets # Command-line tool to prevent committing secret keys into your source code
    difftastic # Syntax-aware diff

    dotnet-sdk
    dotnet-runtime
    dotnetPackages.Nuget


  ];

  programs.bash = {
    blesh.enable = true;
    completion.enable = true;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    viAlias = true;
    configure = {
     # Base config came from https://github.com/nix-community/nixd/blob/main/nixd/docs/editors/nvim-lsp.nix
     customRC = ''
        lua <<EOF
        local g = vim.g
        local o = vim.opt

        -----------------------------------------------------------
        -- General
        -----------------------------------------------------------
        g.mapleader = " "
        g.maplocalleader = "\\"

        o.autowrite = true -- Enable auto write
        -- only set clipboard if not in ssh, to make sure the OSC 52
        -- integration works automatically. Requires Neovim >= 0.10.0
        o.clipboard = vim.env.SSH_TTY and "" or "unnamedplus" -- Sync with system clipboard
        o.swapfile = false -- Don't use swapfile
        o.completeopt = "menuone,noinsert,noselect" -- Autocomplete options
        g.autoformat = true

        -----------------------------------------------------------
        -- Neovim UI
        -----------------------------------------------------------
        o.completeopt = "menu,menuone,noselect"
        o.conceallevel = 2 -- Hide * markup for bold and italic, but not markers with substitutions
        o.confirm = true -- Confirm to save changes before exiting modified buffer
        o.cursorline = true -- Enable highlighting of the current line
        o.expandtab = true -- Use spaces instead of tabs
        o.fillchars = {
          foldopen = "",
          foldclose = "",
          fold = " ",
          foldsep = " ",
          diff = "╱",
          eob = " ",
        }
        o.foldlevel = 99
        o.formatoptions = "jcroqlnt" -- tcqj

        o.ignorecase = true -- Ignore case
        o.number = true -- Show line number

        o.relativenumber = true -- Relative line numbers
        o.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
        o.showmatch = true -- Highlight matching parenthesis
        o.foldmethod = "marker" -- Enable folding (default 'foldmarker')
        o.colorcolumn = "80" -- Line lenght marker at 80 columns
        o.splitright = true -- Vertical split to the right
        o.splitbelow = true -- Horizontal split to the bottom
        o.ignorecase = true -- Ignore case letters when search
        o.smartcase = true -- Ignore lowercase for the whole pattern
        o.smartindent = true -- Insert indents automatically
        o.linebreak = true -- Wrap on word boundary
        o.termguicolors = true -- Enable 24-bit RGB colors
        o.laststatus = 3 -- Set global statusline

        o.scrolloff = 4 -- Lines of context
        o.undofile = true
        o.undolevels = 10000

        o.updatetime = 200 -- Save swap file and trigger CursorHold
        o.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
        o.wildmode = "longest:full,full" -- Command-line completion mode
        o.wrap = false -- Disable line wrap
        o.foldmethod = "indent"

        -----------------------------------------------------------
        -- Tabs, indent
        -----------------------------------------------------------
        o.expandtab = true -- Use spaces instead of tabs
        o.shiftwidth = 4 -- Shift 4 spaces when tab
        o.tabstop = 8 -- 1 tab == 4 spaces
        o.smartindent = true -- Autoindent new lines

        -----------------------------------------------------------
        -- Memory, CPU
        -----------------------------------------------------------
        o.hidden = true -- Enable background buffers
        o.history = 100 -- Remember N lines in history
        o.synmaxcol = 240 -- Max column for syntax highlight
        o.updatetime = 250 -- ms to wait for trigger an event

        -----------------------------------------------------------
        -- Startup
        -----------------------------------------------------------
        -- Disable nvim intro
        o.shortmess:append("sI")

        -- Disable builtin plugins
        local disabled_built_ins = {
          "2html_plugin",
          "getscript",
          "getscriptPlugin",
          "gzip",
          "logipat",
          "netrw",
          "netrwPlugin",
          "netrwSettings",
          "netrwFileHandlers",
          "matchit",
          "tar",
          "tarPlugin",
          "rrhelper",
          "spellfile_plugin",
          "vimball",
          "vimballPlugin",
          "zip",
          "zipPlugin",
          "tutor",
          "rplugin",
          "synmenu",
          "optwin",
          "compiler",
          "bugreport",
          "ftplugin",
        }

        for _, plugin in pairs(disabled_built_ins) do
          g["loaded_" .. plugin] = 1
        end

        ----------------------------
        -- About gruvbox-material --
        ----------------------------
        vim.g.background = dark
        vim.g.gruvbox_material_enable_italic = true
        vim.g.gruvbox_material_background = 'hard'
        vim.g.gruvbox_material_better_performance = 1
        vim.cmd.colorscheme("gruvbox-material")

        -------------------------
        -- About mini-surround --
        -------------------------
        require('mini.surround').setup({
          mappings = {
            add = "gsa", -- Add surrounding in Normal and Visual modes
            delete = "gsd", -- Delete surrounding
            find = "gsf", -- Find surrounding (to the right)
            find_left = "gsF", -- Find surrounding (to the left)
            highlight = "gsh", -- Highlight surrounding
            replace = "gsr", -- Replace surrounding
            update_n_lines = "gsn", -- Update `n_lines`
          },
        })

        ----------------------
        -- About mini-pairs --
        ----------------------
        require('mini.pairs').setup()
      
        -----------------
        -- About noice --
        -----------------
        require("noice").setup({
            routes = {
                {
                    filter = {
                        event = "msg_show",
                        any = {
                            { find = "%d+L, %d+B" },
                            { find = "; after #%d+" },
                            { find = "; before #%d+" },
                            { find = "%d fewer lines" },
                            { find = "%d more lines" },
                        },
                    },
                    opts = { skip = true },
                },
            },
        })
      
        -------------------
        -- About lualine --
        -------------------
        require("lualine").setup({
            options = {
                theme = "auto",
                globalstatus = true,
            },
        })

        ------------------------
        -- About guess-indent --
        ------------------------
        require('guess-indent').setup {}
      
        ----------------------
        -- About treesitter --
        ----------------------
        require("nvim-treesitter.configs").setup({
        	highlight = {
        		enable = true,
        	},
        	indent = {
        		enable = true,
        	},
        })
      
        local function map(mode, lhs, rhs, opts)
          local options = { noremap = true, silent = true }
          if opts then
            options = vim.tbl_extend("force", options, opts)
          end
          vim.keymap.set(mode, lhs, rhs, options)
        end

        
        -- Fast saving with <leader> and w
        map("n", "<leader>w", ":w<CR>", { desc = "Save" })
        -- Fast saving all files with <leader> and W
        map("n", "<leader>W", ":wa<CR>", { desc = "Save All" })

        -- Close current buffer
        -- If this is the last buffer, return to the dashboard.
        map("n", "<leader>q", function()
            local num_listed_buffers = #vim.tbl_filter(function(bufnr)
                return vim.api.nvim_buf_get_option(bufnr, "buflisted")
            end, vim.api.nvim_list_bufs())
            if vim.bo.filetype ~= "snacks_dashboard"  then
                if num_listed_buffers > 0 then
                    require("snacks").bufdelete()
                end
                if num_listed_buffers <= 1 then
                    require("snacks").dashboard()
                end
            else
                vim.cmd("qa")
            end
        end, { desc = "Close Buffer" })

        -- Close all windows and exit from Neovim with <leader> and q
        map("n", "<leader>Q", ":qa<CR>", { desc = "Quit Nvim" })

        -- Make normal j and k presses work with wrapped words
        map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true})
        map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true})
        map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true})
        map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true})

        -- Clear search highlighting with escape
        map("n", "<esc>", "<CMD>nohlsearch<CR>")

        -- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
        map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
        map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
        map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
        map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
        map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
        map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

        -- Add undo break-points when writing non-code
        map("i", ",", ",<c-g>u")
        map("i", ".", ".<c-g>u")
        map("i", ";", ";<c-g>u")

        -- commenting
        map("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
        map("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })

        EOF
      '';

      packages.all.start = with pkgs.vimPlugins; [
        (nvim-treesitter.withPlugins (ps: [ ps.nix ]))
        gruvbox-material
        guess-indent-nvim
        lualine-nvim
        mini-pairs
        mini-surround
        noice-nvim
        nvim-lspconfig
      ];
    };
  };

  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-tty;
  };

  programs.ssh = {
    extraConfig = ''
      Host github.com
        User git
        IdentityFile /etc/nixos/secrets/ssh/github
    '';
  };

  programs.zoxide.enable = true;

  programs.git = {
    enable = true;
    lfs.enable = true;
    prompt.enable = true;

    # Inspriations:
    # - [@waterkip](https://medium.com/@waterkip/my-git-workflow-7f2c145c9d6d)
    config = {
      core = {
        filemode = false;
        editor = "nvim";
        autocrlf = false;
        eol = "lf";

        # Treat spaces before tabs, and all kinds of trailing whitespace as an error
        whitespace = "space-before-tab,trailing-space";

        logallrefupdates = true;
        # TODO: Figure out how to add this back in
        #excludesfile = ~/.gitignore;
      };

      interactive = {
        diffFilter = "delta --color-only";
      };

      delta = {
        navigate = true;  # use n and N to move between diff sections
        dark = true;      # or light = true, or omit for auto-detection
      };

      merge ={
        conflictstyle = "zdiff3";
        tool = "diffview";
      };

      mergetool = {
        prompt = false;
        keepBackup = false;
        "diffview" = {
          cmd = ''nvim -n -c 'DiffviewOpen' "$MERGE"'';
          layout = "LOCAL,BASE,REMOTE / MERGED";
        };
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
        name = "Dominic Grimaldi";
        email = "dev@grimoutlook.dev";
      };
      
      # TODO: Add this back
      # commit = {
      #   template = "/home/dom/.dotfiles/git/templates/default-commit-template.txt";
      # };

      alias = {
        ### Human Git
        untracked = "ls-files -o";
        add = "add -v";
        add-all = "add -Av";
        unstage = "restore --staged";
        unadd = "restore --staged";
        untrack = "rm --cached";
        discard = "reset --hard HEAD";
        sweep = "discard";
        uncommit = "reset --soft HEAD^";
        deepclean = "clean -x -ff -dd";
        undo = "checkout --";

        tags = "tag -l";
        remotes = "remote -v";
        stashes = "stash list";

        amend = "commit --amend --reset-author --no-edit";
        nuke = "!git discard && git deepclean";

        precommit = "diff --cached --diff-algorithm=minimal -w";

        send = "push -u origin HEAD";
        send-please = "send --force-with-lease";
        send-NOW = "send --force";

        autosqaush = "rebase --autosqaush";

        # list all defined aliases;
        aliases = "config --get-regexp alias";

        commitdiff = "!f() { git rev-list --left-right --pretty=oneline \'$\{1}...$\{2}\'; }; f";
        changedfiles = "diff-tree --no-commit-id -r --name-only";
        searchfiles = "log --name-status --source --all -S";
        searchtext = "!f() { git grep \"$*\" $(git rev-list --all); }; f";

        graph = "log --graph --pretty=format:'%C(bold red)%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(yellow)%ad%Creset %C(bold blue)<%an>%Creset' --abbrev-commit --date=human --decorate=full --all";

        diff-commits = "!f() { git rev-list --left-right --pretty=oneline HEAD...origin; }; f";
        diff-no-comment = "difftool --extcmd 'difft --ignore-comments'";
        diff-last-commit = "diff --cached HEAD^";
        word-diff = "diff -w --word-diff=color --ignore-space-at-eol";

        amend-all-and-send-please = "!git add-all && git amend && git send-please";

        new-branch = "!f() { git-new-branch; }; f";

        branches = "branch -a --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(contents:subject) %(color:green)(%(committerdate:relative)) [%(authorname)]' --sort=-committerdate";
        # /HumanGit;

        wip = "commit -am 'wip!'";
        oops = "!f() {git amend && git pleasesend; }; f";
        l = "graph";
        aasp = "amend-all-and-send-please";
      };
    };
  };

  programs.starship = {
    enable = true;
    settings = {
      format = 
        "[](color_orange)" +
        "$os" +
        "$username" +
        "[](bg:color_yellow fg:color_orange)" +
        "$directory" +
        "[](fg:color_yellow bg:color_aqua)" +
        "$git_branch" +
        "$git_status" +
        "[](fg:color_aqua bg:color_blue)" +
        "$c" +
        "$rust" +
        "$golang" +
        "$nodejs" +
        "$php" +
        "$java" +
        "$kotlin" +
        "$haskell" +
        "$python" +
        "[](fg:color_blue bg:color_bg3)" +
        "$docker_context" +
        "$conda" +
        "[](fg:color_bg3 bg:color_bg1)" +
        "$time" +
        "[ ](fg:color_bg1)" +
        "$line_break$character ";
  
      palette = "gruvbox_dark";
  
      palettes.gruvbox_dark = {
        color_fg0 = "#fbf1c7";
        color_bg1 = "#3c3836";
        color_bg3 = "#665c54";
        color_blue = "#458588";
        color_aqua = "#689d6a";
        color_green = "#98971a";
        color_orange = "#d65d0e";
        color_purple = "#b16286";
        color_red = "#cc241d";
        color_yellow = "#d79921";
      };
  
      os = {
        disabled = false;
        style = "bg:color_orange fg:color_fg0";
        symbols = {
          Windows = "󰍲";
          Ubuntu = "󰕈";
          SUSE = "";
          Raspbian = "󰐿";
          Mint = "󰣭";
          Macos = "󰀵";
          Manjaro = "";
          Linux = "󰌽";
          Gentoo = "󰣨";
          Fedora = "󰣛";
          Alpine = "";
          Amazon = "";
          Android = "";
          Arch = "󰣇";
          Artix = "󰣇";
          EndeavourOS = "";
          CentOS = "";
          Debian = "󰣚";
          Redhat = "󱄛";
          RedHatEnterprise = "󱄛";
          Pop = "";
        };
      };
  
      username = {
        show_always = true;
        style_user = "bg:color_orange fg:color_fg0";
        style_root = "bg:color_orange fg:color_fg0";
        format = "[ $user ]($style)";
      };
  
      directory = {
        style = "fg:color_fg0 bg:color_yellow";
        format = "[ $path ]($style)";
        truncation_length = 3;
        truncation_symbol = "…/";
  
        substitutions = {
          "Documents" = "󰈙 ";
          "Downloads" = " ";
          "Music" = "󰝚 ";
          "Pictures" = " ";
          "Developer" = "󰲋 ";
        };
      };
  
      git_branch = {
        symbol = "";
        style = "bg:color_aqua";
        format = "[[ $symbol $branch ](fg:color_fg0 bg:color_aqua)]($style)";
      };
  
      git_status = {
        style = "bg:color_aqua";
        format = "[[($all_status$ahead_behind )](fg:color_fg0 bg:color_aqua)]($style)";
      };
  
      nodejs = {
        symbol = "";
        style = "bg:color_blue";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };
  
      c = {
        symbol = " ";
        style = "bg:color_blue";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };
  
      rust = {
        symbol = "";
        style = "bg:color_blue";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };
  
      golang = {
        symbol = "";
        style = "bg:color_blue";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };
  
      php = {
        symbol = "";
        style = "bg:color_blue";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };
  
      java = {
        symbol = "";
        style = "bg:color_blue";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };
  
      kotlin = {
        symbol = "";
        style = "bg:color_blue";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };
  
      haskell = {
        symbol = "";
        style = "bg:color_blue";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };
  
      python = {
        symbol = "";
        style = "bg:color_blue";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };
  
      docker_context = {
        symbol = "";
        style = "bg:color_bg3";
        format = "[[ $symbol( $context) ](fg:#83a598 bg:color_bg3)]($style)";
      };
  
      conda = {
        style = "bg:color_bg3";
        format = "[[ $symbol( $environment) ](fg:#83a598 bg:color_bg3)]($style)";
      };
  
      time = {
        disabled = false;
        time_format = "%R";
        style = "bg:color_bg1";
        format = "[[  $time ](fg:color_fg0 bg:color_bg1)]($style)";
      };
  
      line_break = {
        disabled = false;
      };
  
      character = {
        disabled = false;
        success_symbol = "[](bold fg:color_green)";
        error_symbol = "[](bold fg:color_red)";
        vimcmd_symbol = "[](bold fg:color_green)";
        vimcmd_replace_one_symbol = "[](bold fg:color_purple)";
        vimcmd_replace_symbol = "[](bold fg:color_purple)";
        vimcmd_visual_symbol = "[](bold fg:color_yellow)";
      };
    };
  };

  environment.shellAliases = {
    # -- General Helpers -----------------------------------------------------------
    cat = "bat";
    cp = "xcp";
    docker = "podman";
    e = "$EDITOR";
    edit = "$EDITOR";
    j = "just";
    log = "lnav";
    mkdir = "mkdir -p";
    reload="source $HOME/.bashrc";
    v = "nvim";

    # -- eza/ls -----------------------------------------------------------------------
    l = "eza ${EZA_DEFAULT_OPTIONS}";
    ls = "eza ${EZA_DEFAULT_OPTIONS}";
    la = "eza -a ${EZA_DEFAULT_OPTIONS}";
    lr = "eza -R ${EZA_DEFAULT_OPTIONS}";
    lsr = "eza -R ${EZA_DEFAULT_OPTIONS}";
    lar = "eza -Ra ${EZA_DEFAULT_OPTIONS}";
    lt = "eza -R --tree ${EZA_DEFAULT_OPTIONS}";

    # -- Nix -----------------------------------------------------------------------
    rebuild = "sudo nixos-rebuild switch";

    # -- Programming ---------------------------------------------------------------
    lf="fd -t f -x dos2unix {} \;";
  };
}
