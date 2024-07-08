{ system ? builtins.currentSystem
}:
let
  pins = import ../npins/default.nix;
  haskellNix = import pins."haskell.nix" { };
  iohkNix = import pins."iohk-nix" { };
  iohkNixCryptoOverlay = builtins.head iohkNix.overlays.crypto;
  iohkNixCryptoInputs = {
    sodium = pins.libsodium // { shortRev = "dbb48cce"; };
    blst = pins.blst // { shortRev = "1l1c905"; };
    secp256k1 = pins.secp256k1 // { shortRev = "acf5c55"; };
  };
  overlays = [
    (self: super: { CHaP = pins."cardano-haskell-packages"; })
  ] ++ haskellNix.overlays ++ [
    (self: super: { inherit iohkNix; })
  ] ++ haskellNix.overlays
  ++ [ (iohkNixCryptoOverlay iohkNixCryptoInputs) ]
  ++ iohkNix.overlays."haskell-nix-extra"
  ++ [
    (self: super: {
      haskell-nix = super.haskell-nix // {
        extraPkgconfigMappings = super.haskell-nix.extraPkgconfigMappings or { } // {
          "libblst" = [ "libblst" ];
          "libsodium" = [ "libsodium-vrf" ];
        };
      };
    })
  ];
in
import pins.nixpkgs { inherit system overlays; config = { allowUnfree = true; }; }
