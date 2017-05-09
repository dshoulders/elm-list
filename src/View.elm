module View exposing (..)

import Html exposing (Html, div, text, a)
import Html.Attributes exposing (style, href)
import Models.Models exposing (Model, ItemId, Route(..))
import Msgs exposing (Msg)
import Items.Browser
import Items.Edit
import Styles.BaseStyles exposing (defaultFontFamily)


view : Model -> Html Msg
view model =
    div
        [ style
            [ ( "max-width", "600px" )
            , ( "margin", "0 auto" )
            , ( "padding", "20px" )
            , ( "font-family", defaultFontFamily )
            , ( "color", "rgb(60, 60, 60)" )
            ]
        ]
        [ page model ]


page : Model -> Html Msg
page model =
    case model.route of
        ItemBrowserRoute ->
            Items.Browser.view model.searchText model.selectedTag model.items model.visibleItemIds

        ItemNewRoute ->
            Items.Edit.view model.tempItem

        ItemEditRoute itemId ->
            Items.Edit.view model.tempItem

        LoginRoute ->
            notFoundView

        NotFoundRoute ->
            notFoundView


notFoundView : Html msg
notFoundView =
    div []
        [ text "Not Found"
        ]
