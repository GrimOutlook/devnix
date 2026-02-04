{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    dogdns # Command-line DNS client
    geoip # API for GeoIP/Geolocation databases
    gping # Ping, but with a graph
    netscanner # Network scanner with features like WiFi scanning, packetdump and more
    ngrep # Network packet analyzer
    rustcat # Port listener and reverse shell
    rustscan # Faster Nmap Scanning with Rust
    trippy # Network diagnostic tool

    # TODO: Check if these are wanted
    # socat
    # ethtool
    # bandwich
    # inetutils
  ];

  environment.shellAliases = {
    dig = "dog";
    nmap = "rustscan";
    nc = "rcat";
    netcat = "rcat";
    ping = "gping";
    traceroute = "trippy";
  };
}
