{ system ? builtins.currentSystem
, pkgs ? import ../nix { inherit system; }
}:

let
  onchain = pkgs.haskell-nix.cabalProject' {
    src = ./.;
    compiler-nix-name = "ghc8107";
    inputMap = {
      "https://input-output-hk.github.io/cardano-haskell-packages" = pkgs.CHaP;
    };
    modules = [
      {
        packages = {
          onchain-poc = {
            doHaddock = false;
            flags.defer-plugin-errors = false;
            ghcOptions = [ "-Werror" ];
          };
          trustless-sidechain-prelude = {
            doHaddock = false;
            ghcOptions = [ "-Werror" ];
          };
          trustless-sidechain = {
            doHaddock = false;
            ghcOptions = [ "-Werror" ];
          };
        };
      }
    ];
  };
in
{
  inherit pkgs onchain;
}


