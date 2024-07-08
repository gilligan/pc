{ project ? import ./. { }
, onchain ? project.onchain
, pkgs ? project.pkgs
}:

onchain.shellFor {
  withHoogle = false;
  tools = {
    cabal = "3.10.1.0";
    hlint = "3.4.1";
  };
  buildInputs = with pkgs; [
    ghcid
    gnumake
    haskellPackages.cabal-fmt
    haskellPackages.fourmolu
    watchexec
  ];
}
