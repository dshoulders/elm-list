module Routing exposing (..)

import Navigation exposing (Location)
import Models.Models exposing (ItemId, Route(..))
import UrlParser exposing (..)


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map ItemBrowserRoute top
        , map ItemNewRoute (s "item" </> (s "new"))
        , map ItemEditRoute (s "item" </> (s "edit" </> string))
        , map LoginRoute (s "login")
        ]


parseLocation : Location -> Route
parseLocation location =
    case (parsePath matchers location) of
        Just route ->
            route

        Nothing ->
            NotFoundRoute
