# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# The NixOS manual can be gound here: https://nixos.org/manual/nixos/stable/#sec-configuration-syntax

# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{ config, lib, pkgs, ... }:

{
  imports = [
    # include NixOS-WSL modules
    <nixos-wsl/modules>
  ];

  # Required for work computer to be able to pull packages
  #security.pki.certificateFiles = [ /etc/nixos/certs/root_certs.pem ];

  wsl.enable = true;
  wsl.defaultUser = "nixos";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

  # Adds rust-overlay
  nixpkgs.overlays = [ (import (builtins.fetchTarball "https://github.com/oxalica/rust-overlay/archive/master.tar.gz")) ];

  environment.systemPackages = with pkgs; [
    # Required to import the certificate before building work computers
    cacert

    # -- General tools ---------------------------------------------------------
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
    git # Distributed version control system
    delta # Syntax-highlighting pager for git
    jujutsu # Git-compatible DVCS that is both simple and powerful
    mdbook # Create books from MarkDown
    ripsecrets # Command-line tool to prevent committing secret keys into your source code
    (rust-bin.nightly.latest.default.override {
    	extensions = [ "rust-analyzer" "clippy" "rustfmt" ];
        targets = [ "x86_64-pc-windows-gnu" "x86_64-pc-windows-msvc" "x86_64-unknown-linux-musl" "wasm32-unknown-unknown" "x86_64-linux-android" ];
    })
  ];

  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-tty;
  };

    programs.neovim = {
      enable = true;
      defaultEditor = true;
    };


  system.activationScripts.importGpgPrivateKey = ''
    ${pkgs.gnupg}/bin/gpg --import /etc/nixos/secrets/gpg/git.asc
    ${pkgs.gnupg}/bin/gpg --import /etc/nixos/secrets/gpg/git.pub.asc
  '';
}
