module Filter.Filter exposing (..)

import Html exposing (Html, div)
import Msgs exposing (Msg)
import Models.Models exposing (Item)
import Filter.TextFilter
import Filter.TagFilter


view : String -> String -> List Item -> Html Msg
view searchText tag items =
    div
        []
        [ Filter.TextFilter.view searchText
        , Filter.TagFilter.view tag items
        ]
