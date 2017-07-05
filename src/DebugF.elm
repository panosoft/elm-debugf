module DebugF
    exposing
        ( Color(..)
        , toStringF
        , log
        , logC
        , logFC
        )

{-|
    More readable debugging.

@docs Color, toStringF, log, logC, logFC
-}

import StringUtils exposing (..)
import Native.DebugF


{-| color definitions
-}
type Color
    = Black
    | Red
    | Green
    | Blue
    | Magenta
    | Yellow
    | Cyan
    | White


{-| more readable toString
-}
toStringF : a -> String
toStringF =
    Native.DebugF.toStringF


{-| more readable log
-}
log : String -> a -> a
log =
    Native.DebugF.log


ansiColor : Color -> Color -> String
ansiColor fg bg =
    "\x1B[" ++ (fgColor fg) ++ ";" ++ (bgColor bg) ++ "m"


{-| Debug.log in color
-}
logC : Color -> Color -> String -> a -> a
logC fg bg prefix object =
    Native.DebugF.logC (ansiColor fg bg) prefix (cleanElmString <| toString object) "\x1B[0m"


{-| DebugF.log in color
-}
logFC : Color -> Color -> String -> a -> a
logFC fg bg prefix object =
    Native.DebugF.logC (ansiColor fg bg) prefix object "\x1B[0m"


fgColor : Color -> String
fgColor color =
    case color of
        Black ->
            "30"

        Red ->
            "31"

        Green ->
            "32"

        Yellow ->
            "33"

        Blue ->
            "34"

        Magenta ->
            "35"

        Cyan ->
            "36"

        White ->
            "37"


bgColor : Color -> String
bgColor color =
    case color of
        Black ->
            "40"

        Red ->
            "41"

        Green ->
            "42"

        Yellow ->
            "43"

        Blue ->
            "44"

        Magenta ->
            "45"

        Cyan ->
            "46"

        White ->
            "47"
