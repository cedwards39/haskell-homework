with (import <nixpkgs> {});

let
  hp = haskellPackages.extend (self: super: {
    haskell-homework = self.callPackage ./. {};
  });
  easy-hls = pkgs.callPackage easy-hls-src { ghcVersions = [hp.ghc.version]; };

in
hp.shellFor {
  packages = h: [h.haskell-homework];
  buildInputs = [
    cabal-install
    ghcid
    stylish-haskell
  ];
}
