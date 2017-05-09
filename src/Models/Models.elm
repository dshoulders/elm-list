module Models.Models exposing (..)


type alias Model =
    { items : List Item
    , visibleItemIds : List ItemId
    , searchText : String
    , selectedTag : String
    , tempItem : Item
    , route : Route
    }


type alias ItemId =
    String


type alias Item =
    { id : ItemId
    , title : String
    , notes : String
    }


type Route
    = ItemBrowserRoute
    | ItemNewRoute
    | ItemEditRoute ItemId
    | LoginRoute
    | NotFoundRoute
