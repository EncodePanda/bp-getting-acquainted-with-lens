---
title: Getting acquainted with Lens (part 1)
desc: All you wanted to know about Lens but dare to ask
author: Pawel Szulc
tags: haskell, lens
icon: lens.jpg
disclaimer: Content of this blog and the source code is <a href="https://github.com/EncodePanda/bp-getting-acquainted-with-lens">available on Github</a>. Repository is divided into small commits so that you can follow along if you prefer jumping straight into the code. <br/> This post is based on a <a href="https://www.youtube.com/watch?v=LBiFYbQMAXc">talk</a> I did at Haskell.Love 2020
---

### Introduction

In this post we will explore a concept of a Lens. More concretely the [Lens library](https://hackage.haskell.org/package/lens).

1. What problem they are trying to solve?
2. How we can use them?
3. How they are being implemented?

### What problem they are trying to solve?

It is my observation that any newcommer to the Haskell ecosystem, who gets excited with the language, stumbles upon two limitations of the language design. Mainly:

1. Record syntax
2. Strings

Those two are suprising to newcomers, especially because both record syntax and Strings are considered a no-brainer in almost every other programming language. Writing about String representation in Haskell deserves a blog post on its own. Today we want to focus on a **record syntax**, trying to understand what are its limitations and main source of frustration.
And frustrating in did it is. Below few quotes scrapped from the Internet to back that claim.

> *"The record system is a continual source of pain"*
- Stephen Diehl

> *"What is your least favorite thing about Haskell? Records are still tedious"*
- 2018 State of Haskell Survey


> *"Shitty records."*
- Someone on reddit

### An example

[Someone famous](https://en.wikipedia.org/wiki/Linus_Torvalds) once said "Talk is cheap, show me the code". In that sprit let's explore an example project in which those problems are clearly visible.

We will use the latest version of GHC Haskell

```bash
{{{{ shellOutput ghc --version }}}}
```

and a standard cabal project

```bash
{{ file bp-getting-acquainted-with-lens.cabal  }}
```

Imagine we are writing a tool allowing conference organizers to maintain their events. We have a datatype `Conference`

```haskell
{{ fileSection src/EncodePanda/Lens.hs conference-datatype }}
```

where `Organizer` is

```haskell
{{ fileSection src/EncodePanda/Lens.hs organizer-datatype }}
```

and `Speaker` is

```haskell
{{ fileSection src/EncodePanda/Lens.hs speaker-datatype }}
```

Organizer has a `Name` and `Address`. `Name` is a simple record with `firstName` and `lastName`

```haskell
{{ fileSection src/EncodePanda/Lens.hs name-datatype }}
```

and `Address` encapsulates `street`, `city` and `country`

```haskell
{{ fileSection src/EncodePanda/Lens.hs address-datatype }}
```

Now we just need example of a conference organizer, a value that we could play with in the REPL . While creating this blog post I could not miss the opportunity to pay my tribute to [Oli Makhasoeva](https://twitter.com/Oli_kitty) - one of the best conference organizers on the planet, master mind behind such events as [Haskell Love](http://haskell.love) or [Scala Love](http://scala.love/conf).

Let's create a value of type `Organizer` called `oli`

```haskell
{{ fileSection src/EncodePanda/Lens.hs oli }}
```

### Fetching values from records

We can observe that both `name` and `contact` are in fact accessor functions that allow us to retrieve values from records

{{{ghci session1
:l src/EncodePanda/Lens.hs
:t name
name oli
:t contact
contact oli
}}}
