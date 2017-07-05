port module Test.App exposing (..)

import Platform
import Dict exposing (Dict)
import DebugF exposing (Color(..), toStringF)
import Json.Decode


port exitApp : Float -> Cmd msg


port externalStop : (() -> msg) -> Sub msg


type alias Model =
    {}


type Msg
    = Nop


init : ( Model, Cmd Msg )
init =
    let
        l =
            DebugF.log "test"
                { a = 1
                , b = "this is a string"
                , c =
                    { x = 1
                    , y = "string"
                    }
                , d = ( 1, 2 )
                , e = [ 3, 4 ]
                , f = Dict.fromList [ ( 1, "a" ), ( 2, "b" ) ]
                }
    in
        {} ! [ exitApp 0 ]


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
    { string = "stuff\n"
    , more = moreStuff
    , num = 1
    }


moreStuff : MoreStuff
moreStuff =
    { anotherString = "more\nstuff"
    , anotherNum = 100
    }


test : String
test =
    let
        fc =
            DebugF.logFC Red Black "stuff" <| "prefix: " ++ (toStringF stuff)

        c =
            DebugF.logC Black Yellow "moreStuff" moreStuff

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


main : Program Never Model Msg
main =
    Platform.program
        { init = init
        , update = update
        , subscriptions = subscriptions
        }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Nop ->
            model ! []


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
