module Filter.TextFilter exposing (..)

import Msgs exposing (..)
import Html exposing (Html, input)
import Html.Attributes exposing (value, placeholder, style)
import Html.Events exposing (onInput)
import Styles.BaseStyles exposing (inputStyles)


view : String -> Html Msg
view searchText =
    input
        [ onInput Msgs.TextSearch
        , value searchText
        , placeholder "Search"
        , style inputStyles
        ]
        []
