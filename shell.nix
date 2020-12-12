# shell.nix
{ pkgs ? import ./haskell-pkgs.nix
}:

let
  hsPkgs = import ./. { inherit pkgs; };
  hlint = import ./hlint.nix { inherit pkgs; };
  apply-refact = import ./apply-refact.nix { inherit pkgs; };
  stylish-haskell = import ./stylish-haskell.nix { inherit pkgs; };
  cabal-fmt = import ./cabal-fmt.nix { inherit pkgs; };
in
  hsPkgs.shellFor {
    tools = { cabal = "3.2.0.0"; };

    shellHook = ''
      format-all () {
        git rev-parse --show-toplevel | xargs -i stylish-haskell -ric "{}/.stylish-haskell.yaml" $@
        cabal-fmt --inplace bp-getting-acquainted-with-lens.cabal
      }

      hlint-all () {
        hlint .
      }

      hlint-all-fix () {
        find . -path ./dist-newstyle -prune -o -name \*.hs -exec hlint --refactor --refactor-options="--inplace" {} \;
      }

      create-blog-posts () {
        cabal build
        gitchapter .
        csplit compiledArticle.md '/next post/'
        mv ./xx00 ./2020-12-15-getting-acquainted-with-lens.md
        mv ./xx01 ./2020-12-25-getting-acquainted-with-lens-part2.md
        tail -n +3 2020-12-25-getting-acquainted-with-lens-part2.md > "temp.tmp"
        mv temp.tmp 2020-12-25-getting-acquainted-with-lens-part2.md
        rm compiledArticle.md
      }

    '';

    buildInputs =
      [ pkgs.haskellPackages.ghcid
        pkgs.haskellPackages.hp2pretty
        pkgs.coreutils
        cabal-fmt
        hlint
        apply-refact
        stylish-haskell
      ];
  }
