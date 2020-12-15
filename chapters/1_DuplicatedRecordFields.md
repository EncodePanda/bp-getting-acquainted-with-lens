
But when we do a slight modification to our code, where not only `Organizer` has a `name` field:

```diff
{{{{ shellOutput git diff HEAD^ HEAD src/EncodePanda/Lens2.hs | sed -e '1,6d' | sed '/^@/d' | sed '/\[-- end snippet\]/d' }}}}
```

the code suddenly stops compiling:

```haskell
$> cabal build

src/EncodePanda/Lens2.hs:22:5: error:
    Multiple declarations of ‘name’
    Declared at: src/EncodePanda/Lens2.hs:15:5
                 src/EncodePanda/Lens2.hs:22:5
   |
22 |   { name :: Name
   |     ^^^^

src/EncodePanda/Lens2.hs:22:5: error:
    Multiple declarations of ‘name’
    Declared at: src/EncodePanda/Lens2.hs:7:5
                 src/EncodePanda/Lens2.hs:22:5
   |
22 |   { name :: Name
   |     ^^^^
```

There is one trick we could do make it work...Have you guessed it? Yes, it is GHC. We can always add a language extension:

```diff
{{{{ shellOutput git diff HEAD^ HEAD src/EncodePanda/Lens2.hs | sed -e '1,5d' | head -n 2 }}}}
```

And things compile again!

```haskell
$> cabal build

{{{{ shellOutput cabal build }}}}
```

But when we try to use the `name` function:

```haskell
organizerName :: Conference -> Name
organizerName conference =
  conference & organizer & name
```

The compiler gives us a quick reality check:

```haskell
src/EncodePanda/Lens2.hs:76:28: error:
    Ambiguous occurrence ‘name’
    It could refer to
       either the field ‘name’, defined at src/EncodePanda/Lens2.hs:23:5
           or the field ‘name’, defined at src/EncodePanda/Lens2.hs:16:5
           or the field ‘name’, defined at src/EncodePanda/Lens2.hs:8:5
   |
76 |   conference & organizer & name
```

It seems that we can define multiple records with the same field name, but we are not allowed to use it.
