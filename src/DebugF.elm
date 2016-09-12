module DebugF exposing (..)

import Native.DebugF


toStringF : a -> String
toStringF =
    Native.DebugF.toStringF


log : String -> a -> a
log =
    Native.DebugF.log
