# Formatted Debug logging

> Functions that work like `Debug.log` and `toString` but are formatted so humans can read them.

## Install

Since the Elm Package Manager doesn't allow for Native code and this uses Native code, you have to install it directly from GitHub, e.g. via [elm-github-install](https://github.com/gdotdesign/elm-github-install) or some equivalent mechanism.

## Usage

```elm
type alias Stuff =
    { string : String
    , more : MoreStuff
    , num : Int
    }


type alias MoreStuff =
    { anotherString : String
    , anotherNum : Int
    }


stuff : Stuff
stuff =
    { string = "stuff"
    , more = moreStuff
    , num = 1
    }


moreStuff : MoreStuff
moreStuff =
    { anotherString = "more"
    , anotherNum = 100
    }


test : String
test =
    let
        ff =
            DebugF.log "stuff" <| "prefix: " ++ (toStringF stuff)

        f =
            DebugF.log "moreStuff" moreStuff

        ll =
            Debug.log "stuff" <| "prefix: " ++ (toString stuff)

        l =
            Debug.log "moreStuff" moreStuff
    in
        ""
```

Produces the following output, first the Elm Debug output then this library's output:

```
moreStuff: { anotherString = "more", anotherNum = 100 }
stuff: "prefix: { string = \"stuff\", more = { anotherString = \"more\", anotherNum = 100 }, num = 1 }"

-------------------------moreStuff-------------------------

{
  anotherString = "more",
  anotherNum = 100
}

-------------------------stuff-------------------------

"  prefix: {
    string = "stuff",
    more = {
      anotherString = "more",
      anotherNum = 100
    },
    num = 1
  }"
```

## Warning

This library is still in alpha.
