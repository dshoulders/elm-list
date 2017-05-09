module ActionsPanel.Panel exposing (..)

import Msgs exposing (..)
import Html exposing (Html, div, span, text)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)


view : Html Msg
view =
    div
        [ style panelStyle ]
        [ span
            [ style actionStyle
            , onClick Msgs.ClearFilter
            ]
            [ text "× Clear Filter" ]
        , span
            [ style actionStyle
            , onClick (Msgs.ChangeLocation "/item/new")
            ]
            [ text "+ Add New Item" ]
        ]



-- Styles


panelStyle =
    [ ( "marginBottom", "15px" ) ]


actionStyle =
    [ ( "fontSize", "13px" )
    , ( "cursor", "pointer" )
    , ( "color", "#7b7b7b" )
    , ( "marginRight", "15px" )
    ]
