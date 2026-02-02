{config, lib, pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    cacert # Bundle of X.509 certificates of public Certificate Authorities (CA)
  ];
  security.pki.certificateFiles = [
        "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt"
        ./trusted-cert.pem
  ];
}
