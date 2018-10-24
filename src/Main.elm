module Main exposing (Model, Msg(..), init, main, update, view)

import Brick exposing (Brick)
import Browser
import Browser.Events exposing (onAnimationFrameDelta)
import Html exposing (Html, div, h1, img, text)
import Html.Attributes exposing (src)
import Svg exposing (..)
import Svg.Attributes exposing (..)



---- MODEL ----


type alias Model =
    { brick : Brick
    }


init : ( Model, Cmd Msg )
init =
    ( { brick = Brick.init }, Cmd.none )



---- UPDATE ----


type Msg
    = TimeUpdate Float


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        TimeUpdate time ->
            let
                brick =
                    model.brick

                newBrick =
                    Brick.fall time brick

                newModel =
                    { model | brick = newBrick }
            in
            ( newModel, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    svg [ width "600", height "800", viewBox "0 0 600 800" ]
        [ Brick.render model.brick ]



---- PROGRAM ----


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch [ onAnimationFrameDelta TimeUpdate ]


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = subscriptions
        }
