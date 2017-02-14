port module Test.App exposing (..)

import Platform
import Dict exposing (Dict)
import DebugF
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
