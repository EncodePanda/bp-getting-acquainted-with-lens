
But `OverloadedLabels` comes with a nice syntatic sugar where we can reference just the symbol directly by prefixing the `Symbol` with a hash `#` and let the type inference magic do the rest work for us.

```diff
{{{{ shellOutput git diff gch-end-3 gch-begin-4 src/EncodePanda/OverloadedLabels.hs | sed -e '1,5d' | sed '/^@/d' | sed '/\[-- end snippet\]/d' }}}}
```

Underneath, it desugars to a function call to `fromLabel`.

### Leveraging OverloadedLabels for record access

We can now take `OverloadedLabels` for a spin, to see if they can help us with our issue. As a reminder, the problem at hand is a fact that (even though we have `DuplicateRecordFields` turned on) we can not reuse duplicated accessor function:

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
