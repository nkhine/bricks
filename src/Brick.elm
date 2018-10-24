module Brick exposing (Brick, fall, init, render)

import Svg exposing (..)
import Svg.Attributes exposing (..)


type alias Brick =
    { y : Float
    , x : Float
    , colors : List Color
    }


init : Brick
init =
    { y = 10.0, x = 0.0, colors = [ red, green, blue ] }


fall : Float -> Brick -> Brick
fall dt brick =
    { brick | y = brick.y + 1 * dt }


type Color
    = Color String


red =
    Color "#ff0000"


green =
    Color "#00ff00"


blue =
    Color "#0000ff"


render : Brick -> Svg msg
render brick =
    g []
        (List.indexedMap (renderBlock brick) brick.colors)


renderBlock : Brick -> Int -> Color -> Svg msg
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
