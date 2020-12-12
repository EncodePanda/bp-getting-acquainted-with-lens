{ pkgs ? import ./haskell-pkgs.nix
, haskellCompiler ? "ghc8102"
}:
pkgs.haskell-nix.cabalProject {
  src = pkgs.haskell-nix.haskellLib.cleanGit {
    name = "bp-getting-acquainted-with-lens";
    src = ./.;
  };
  compiler-nix-name = haskellCompiler;
}
