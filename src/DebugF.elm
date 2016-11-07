module DebugF exposing (..)

{-|
    More readable debugging.

@docs toStringF, log
-}

import Native.DebugF


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
