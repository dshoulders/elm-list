module Models.InitialModel exposing (..)

import Models.Models exposing (..)
import Update.Reducers exposing (modelForRoute)


initialModel : Route -> Model
initialModel route =
    modelForRoute route
        { items = []
        , visibleItemIds = []
        , searchText = ""
        , selectedTag = ""
        , tempItem = Item "" "" ""
        , route = route
        }
