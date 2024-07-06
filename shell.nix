{ pkgs ? import ./nix {} }:

pkgs.mkShell {
  packages = with pkgs; [ nixpkgs-fmt hello ];
}
