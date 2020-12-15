
The idea is to provide different instances for `"name"` and different accessor functions called `name`:

```diff
{{{{ shellOutput git diff gch-end-4 gch-begin-5 src/EncodePanda/Lens3.hs | sed -e '1,7d' | sed '/^@/d' | sed '/\[-- end snippet\]/d' }}}}
```

It is suprising that even though we are reusing `name` functions to implement those typeclasses, the compiler is suddenly happy. In other words: we've build up this boilerplate in order to workaround the fact that different accessor functions that have the same names could not be used. At the same time, that workaround is making use of those functions. Why this is happening is probably a good idea for a different project.
