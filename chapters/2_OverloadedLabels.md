
### Is that it? Are we done?

Before we give up, there is fortunately one more trick we can use. It's called `OverloadedLabels` but it requires bunch of other extendsions to be enabled. We turned them on for the whole project by modifing the cabal file (along with the `DuplicatedRecordFields` that've used before)

```diff
{{{{ shellOutput git diff gch-end-2 gch-begin-3 bp-getting-acquainted-with-lens.cabal | sed -e '1,5d' | sed '/^@/d' }}}}
```

What `OverloadedLabels` gives us is a typeclass `IsLabel` from `GHC.OverloadedLabels`

```haskell
module GHC.OverloadedLabels where
(...)
class IsLabel (x :: Symbol) a where
  fromLabel :: a
```

It is a typeclass that we define for a particular type `a` and a `Symbol` (think of it as type level `String`). As an example we can create an instance of it for a `Speaker` and `"encodepanda"`

```haskell
{{ fileSection src/EncodePanda/OverloadedLabels.hs islabel }}
```

And now can us it as we would normally use any other typeclass.

```haskell
{{ fileSection src/EncodePanda/OverloadedLabels.hs pawel }}
```
