module Main exposing (..)

import Msgs exposing (Msg)
import Models.Models exposing (Model)
import Models.InitialModel exposing (initialModel)
import Update.Update exposing (update)
import View exposing (view)
import Ports exposing (..)
import Navigation exposing (Location)
import Routing


init : Location -> ( Model, Cmd Msg )
init location =
    let
        currentRoute =
            Routing.parseLocation location
    in
        ( initialModel currentRoute, fetchList "" )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ receiveList Msgs.OnReceiveList
        , afterSaveItem Msgs.AfterSaveItem
        ]



-- MAIN


main : Program Never Model Msg
main =
    Navigation.program Msgs.OnLocationChange
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
