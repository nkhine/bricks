module Main exposing (Brick, Model, Msg(..), init, main, update, view)

import Browser
import Html exposing (Html, div, h1, img, text)
import Html.Attributes exposing (src)
import Svg exposing (..)
import Svg.Attributes exposing (..)



---- MODEL ----


type alias Model =
    { bricks : List Brick
    }


type alias Brick =
    { y : Float
    , x : Float
    , colors : List Color
    }


type Color
    = Color String


red =
    Color "#ff0000"


green =
    Color "#00ff00"


blue =
    Color "#0000ff"


init : ( Model, Cmd Msg )
init =
    ( { bricks = [ { y = 10.0, x = 0.0, colors = [ red, green, blue ] } ] }, Cmd.none )



---- UPDATE ----


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    svg [ width "600", height "800", viewBox "0 0 600 800" ]
        (List.map renderBrick model.bricks)


renderBrick : Brick -> Svg Msg
renderBrick brick =
    g []
        (List.indexedMap (renderBlock brick) brick.colors)


renderBlock : Brick -> Int -> Color -> Svg Msg
renderBlock brick index (Color color) =
    rect
        [ x (String.fromFloat brick.x)
        , y
            (String.fromFloat
                (brick.y
                    + (toFloat index * 50.0)
                )
            )
        , rx "15"
        , ry "15"
        , width "50"
        , height "50"
        , fill color
        ]
        []



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
