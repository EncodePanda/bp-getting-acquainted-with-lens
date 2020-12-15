
# Setting values

Imagine we have a value of type `Conference`:

```haskell
{{ fileSection src/EncodePanda/Lens3.hs conference }}
```

We also have two speakers who would love to be part of this conference:

```haskell
{{ fileSection src/EncodePanda/Lens3.hs speakers }}
```

At first, setting a new value does not seem to be scary.

```
conference { speakers = [ pawel, marcin ] }
```

It seems pretty reasonable - it reuses syntax for the creation of a value. Small, nice, compact.
However, the moment you try to do something a bit more complicated, things get really messy really quickly.

For example, something as simple as making all speakers for a given conference marked as not ready:

```haskell
{{ fileSection src/EncodePanda/Lens3.hs allSpeakersNotReady }}
```

Or modifing an organizer's email address using a function:

```haskell
{{ fileSection src/EncodePanda/Lens3.hs changeOrganizerEmail }}
```

In both example we have to very explicitly say each little tiny detail of how the new value should look like. If that is not imperative programming, I don't know what is.

### Now what?

Is that it? Is there now hope for us? Where do we go from here? [Follow this link](https://encodepanda.com/posts/2020-12-25-getting-acquainted-with-lens-part2.html) to learn how **Lens** can help us.
