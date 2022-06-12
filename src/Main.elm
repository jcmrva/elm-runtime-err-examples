module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Events exposing (onClick)
import Random
import FailUtils


main : Program () Model Msg
main =
    Browser.document
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }


type alias Model =
    { someInt: Int }

init : () -> ( Model, Cmd Msg )
init _ =
    ({ someInt = 1 }, Cmd.none)


type Msg
    = MsgLoop Int
    | MutualRecursion
    | SingleRecursion
    | ModDivByZero
    | FunctionEquality
    | StringLength

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MsgLoop max ->
            (model, Random.generate MsgLoop (Random.int 1 max) )
        MutualRecursion ->
            ({ model | someInt = FailUtils.mutualRecurseFuncs 1 }, Cmd.none)
        SingleRecursion ->
            ({ model | someInt = FailUtils.nonTailRecursion 1 }, Cmd.none)
        ModDivByZero ->
            ({ model | someInt = FailUtils.modDivByZero 1 }, Cmd.none)
        FunctionEquality ->
            ({ model | someInt = FailUtils.functionEquality () }, Cmd.none)
        StringLength ->
            ({ model | someInt = FailUtils.largeStringLength 9999999999999 }, Cmd.none)


type alias Document msg =
    { title : String
    , body : List (Html msg)
    }

view : Model -> Document Msg
view _ =
    { title = "Elm Runtime Errors"
    , body =
        [ div [ ]
            [ button [ onClick (MsgLoop 1) ] [ text "Message loop" ]
            , button [ onClick MutualRecursion ] [ text "Mutual recursion" ]
            , button [ onClick SingleRecursion ] [ text "Single recursion" ]
            , button [ onClick ModDivByZero ] [ text "Modulus division by zero" ]
            , button [ onClick FunctionEquality ] [ text "Function equality" ]
            , button [ onClick StringLength ] [ text "String.length on large values" ]
            ]
        ]
    }
