module Items.Browser exposing (..)

import Html exposing (Html, div)
import Models.Models exposing (Item, ItemId)
import Msgs exposing (Msg)
import Filter.Filter
import ActionsPanel.Panel
import Items.List


view : String -> String -> List Item -> List ItemId -> Html Msg
view searchText tag items visibleItemIds =
    div
        []
        [ Filter.Filter.view searchText tag items
        , ActionsPanel.Panel.view 
        , Items.List.view items visibleItemIds
        ]
