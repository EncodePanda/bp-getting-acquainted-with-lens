# bp-getting-acquainted-with-lens

## Developement

### Pre-requirements

This project is build using [haskell.nix](https://input-output-hk.github.io/haskell.nix/). This means that the only requirement for building this project is having [Nix installed](https://nixos.org/download.html) on your system.

In order to *download* GHC compiler from pre-build cache, please add the following sections to `/etc/nix/nix.conf` or `~/.config/nix/nix.conf`.

```
trusted-public-keys = [...] hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ= [...]
substituters = [...] https://hydra.iohk.io [...]
```

Otherwise Nix will have to build several copies of GHC, before building this project - and this will take a while.

### Building the project

Enter the nix-shell

```
$> nix-shell
trace: Using latest index state for bp-getting-acquainted-with-lens!
trace: Using index-state: 2020-09-14T00:00:00Z for haskell-template-project
trace: Shell for bp-getting-acquainted-with-lens
trace: Shell for bp-getting-acquainted-with-lens
trace: Using index-state: 2020-05-31T00:00:00Z for hoogle
(...)
trace: Using latest index state for cabal-install!
trace: Using index-state: 2020-09-14T00:00:00Z for cabal-install
```

Run cabal

```
[nix-shell:~/bp-getting-acquainted-with-lens]$ cabal build
Resolving dependencies...
Build profile: -w ghc-8.10.2 -O1
```

### The blog post

This repository holds content (both markdown and source code) for the [Getting acquainted with Lens (part 1)](http://encodepanda.com/posts/2020-12-15-getting-acquainted-with-lens.html) and [Getting acquainted with Lens (part 2)](http://encodepanda.com/posts/2020-12-25-getting-acquainted-with-lens-part2.html) blog posts.
It is being build using amazing [GitChapter](https://github.com/chrissound/GitChapter) by[@chrisczynski](https://twitter.com/chrisczynski). Thank you Chris!

To build the article simply run (from the nix-shell):

```
$> create-blog-posts
```

This command creates two files

```
$> ls | grep 2020-12
2020-12-15-getting-acquainted-with-lens.md
2020-12-25-getting-acquainted-with-lens-part2.md
```
