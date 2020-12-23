module Main exposing (..)

import Browser
import Html exposing (Html, text)
import Html.Attributes exposing (style)
import Material
import Material.Button as Button
import Material.Elevation as Elevation
import Material.Options as Options exposing (css, styled)
import Material.TextField as TextField


type alias Model =
    { mdc : Material.Model Msg
    }


defaultModel : Model
defaultModel =
    { mdc = Material.defaultModel
    }


type Msg
    = Mdc (Material.Msg Msg)
    | Click


main : Program () Model Msg
main =
    Browser.element
        { init = \_ -> init
        , subscriptions = subscriptions
        , update = update
        , view = view
        }


init : ( Model, Cmd Msg )
init =
    ( defaultModel, Material.init Mdc )


subscriptions : Model -> Sub Msg
subscriptions model =
    Material.subscriptions Mdc model


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Mdc msg_ ->
            Material.update Mdc msg_ model

        Click ->
            ( model, Cmd.none )

view : Model -> Html Msg
view model =
    Html.div
        [ style "display" "flex"
        , style "justify-content" "center"
        , style "height" "80%"
        ]
        [ Html.div
            [ style "display" "flex"
            , style "flex-direction" "column"
            , style "justify-content" "center"
            , style "width" "30%"
            ]
            [ form model ]
        ]

form : Model -> Html Msg
form model =
    styled Html.div
       [ Elevation.z5
       , css "display" "flex"
       , css "justify-content" "space-evenly"
       , css "flex-direction" "column"
       , css "height" "30%"
       , css "padding" "5%"
       , css "margin" "5%"
       ]
       [ TextField.view Mdc
           "email-input"
           model.mdc
           [ TextField.label "Email"
           ]
           []
       , TextField.view Mdc
           "password-input"
           model.mdc
           [ TextField.label "Password"
           , TextField.password
           ]
           []
       , Button.view Mdc
           "submit-button"
           model.mdc
           [ Button.ripple
           , Button.raised
           , Options.onClick Click
           , css "height" "20%"
           ]
           [ text "Submit" ]
       ]
