---
title: Getting acquainted with Lens (part 1)
desc: All you wanted to know about Lens but dare to ask
author: Pawel Szulc
tags: haskell, lens
icon: lens.jpg
disclaimer: Content of this blog and the source code is <a href="https://github.com/EncodePanda/bp-getting-acquainted-with-lens">available on Github</a>. Repository is divided into small commits so that you can follow along if you prefer jumping straight into the code. <br/> This post is based on a <a href="https://www.youtube.com/watch?v=LBiFYbQMAXc">talk</a> I did at Haskell.Love 2020 <br/> I want to personally thank <a href="https://twitter.com/cateroxl">@cateroxl</a> for proof-reading and helping me fix all the typos I've created while writing this post. <a href="https://twitter.com/cateroxl">@cateroxl</a> you rock!
---

### Introduction

In this post we will explore a concept of a Lens. More concretely the [Lens library](https://hackage.haskell.org/package/lens).

1. What problem they are trying to solve?
2. How we can use them?
3. How they are being implemented?

### What problem they are trying to solve?

It is my observation that any newcomer to the Haskell ecosystem, who gets excited with the language, stumbles upon two limitations of the language design. Mainly:

1. Record syntax
2. Strings

Those two are suprising to newcomers, especially because both record syntax and strings are considered a no-brainer in almost every other programming language. Writing about string representation in Haskell deserves a blog post on its own. Today we want to focus on **record syntax**, trying to understand what are its limitations and main source of frustration.
And frustrating indeed it is. Below are a few quotes scrapped from the Internet to back that claim.

> *"The record system is a continual source of pain"*
- Stephen Diehl

> *"What is your least favorite thing about Haskell? Records are still tedious"*
- 2018 State of Haskell Survey

> *"Shitty records."*
- Someone on reddit

### An example

[Someone famous](https://en.wikipedia.org/wiki/Linus_Torvalds) once said "Talk is cheap, show me the code". In that sprit let's explore an example project in which those problems are clearly visible.

We will use the latest version of GHC Haskell:

```bash
{{{{ shellOutput ghc --version }}}}
```

and a standard cabal project:

```bash
{{ file bp-getting-acquainted-with-lens.cabal  }}
```

Imagine we are writing a tool allowing conference organizers to maintain their events. We have a datatype `Conference`:

```haskell
{{ fileSection src/EncodePanda/Lens.hs conference-datatype }}
```

where `Organizer` is:

```haskell
{{ fileSection src/EncodePanda/Lens.hs organizer-datatype }}
```

and `Speaker` is:

```haskell
{{ fileSection src/EncodePanda/Lens.hs speaker-datatype }}
```

Organizer has a `Name` and `Address`. `Name` is a simple record with `firstName` and `lastName`:

```haskell
{{ fileSection src/EncodePanda/Lens.hs name-datatype }}
```

and `Address` encapsulates `street`, `city` and `country`:

```haskell
{{ fileSection src/EncodePanda/Lens.hs address-datatype }}
```

Now we just need an example of a conference organizer, a value that we could play with in the REPL. While creating this blog post, I could not miss the opportunity to pay my tribute to [Oli Makhasoeva](https://twitter.com/Oli_kitty) - one of the best conference organizers on the planet, the master mind behind such events as [Haskell Love](http://haskell.love) or [Scala Love](http://scala.love/conf).

Let's create a value of type `Organizer` called `oli`:

```haskell
{{ fileSection src/EncodePanda/Lens.hs oli }}
```

### Fetching values from records

We can observe that both `name` and `contact` are in fact accessor functions that allow us to retrieve values from records:

{{{ghci session1
:l src/EncodePanda/Lens.hs
:t name
name oli
:t contact
contact oli
}}}

This can even look nicer if we use `&` operator from `Data.Function`:


{{{ghci session1
import Data.Function ((&))
:t (&)
}}}

Here we see that `&` is a simple function application, where instead of providing function name and the argument (as we would normally do):

{{{ghci session1
length [4, 6, 8]
}}}

we provide first the argument and then the function name:

{{{ghci session1
[4, 6, 8] & length
}}}

This allow us to change previous call to `name` from:

{{{ghci session1
name oli
}}}

to:

{{{ghci session1
oli & name
}}}

It does not seem much at first, but you can observe that this approach composes nicely when you want to read the value of a deeply nested record:

{{{ghci session1
oli & name & firstName
}}}

This resembles dot-like record access that is available in other languages. Correctly formatted makes accessing deeply nested values a pleasure experience

```haskell
{{ fileSection src/EncodePanda/Lens.hs organizerCountry }}
```
