{ system ? builtins.currentSystem
}:
let
  pins = import ../npins/default.nix;
  haskellNix = import pins."haskell.nix" { };
  config = {
    allowUnfree = true;
  };
  overlays = [ ] ++ haskellNix.overlays;
in
import pins.nixpkgs { inherit system overlays config; }
