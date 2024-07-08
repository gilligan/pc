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
          trustless-sidechain.doHaddock = false;
          trustless-sidechain-prelude.doHaddock = false;
          onchain-poc.doHaddock = false;
          onchain-poc.flags.defer-plugin-errors = false;
          trustless-sidechain.ghcOptions = [ "-Werror" ];
          onchain-poc.ghcOptions = [ "-Werror" ];
          trustless-sidechain-prelude.ghcOptions = [ "-Werror" ];
        };
      }
    ];
  };
in
{
  inherit pkgs onchain;
}


