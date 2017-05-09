module Items.List exposing (..)

import Html exposing (div, span, a, text, Html)
import Html.Attributes exposing (class, href, style)
import Html.Events exposing (onDoubleClick)
import Msgs exposing (Msg)
import Models.Models exposing (Item, ItemId)
import Regex exposing (Regex, regex, replace)
import String exposing (startsWith)
import Styles.BaseStyles exposing (tagStyles, defaultColours, breakLongWords)


view : List Item -> List ItemId -> Html Msg
view response visibleItemIds =
    response
        |> List.filter (\item -> List.member item.id visibleItemIds)
        |> List.sortWith titleCaseInsensitive
        |> list


list : List Item -> Html Msg
list items =
    div []
        (List.map itemDisplay items)


itemDisplay : Item -> Html Msg
itemDisplay item =
    div [ style itemStyles ]
        [ div [ style titleStyles, onDoubleClick (Msgs.ChangeLocation ("item/edit/" ++ item.id)) ]
            [ text item.title ]
        , div [ style noteStyles ]
            (notesDisplay item.notes)
        ]


notesDisplay : String -> List (Html Msg)
notesDisplay notes =
    notes
        |> markTags
        |> splitMarks
        |> List.map notesHTML


markTags : String -> String
markTags =
    replace Regex.All (regex "(https?:\\/\\/\\S*)|(\\B#\\w*[a-zA-Z]+\\w*)") (\{ match } -> "|" ++ match ++ "|")


splitMarks : String -> List String
splitMarks str =
    String.split "|" str


notesHTML : String -> Html Msg
notesHTML str =
    if startsWith "http" str then
        a [ href str ] [ text str ]
    else if startsWith "#" str then
        span [ style tagStyles ] [ text str ]
    else
        text str


titleCaseInsensitive : { a | title : String } -> { b | title : String } -> Order
titleCaseInsensitive a b =
    compare (String.toLower a.title) (String.toLower b.title)



-- Styles


itemStyles : List ( String, String )
itemStyles =
    [ ( "marginBottom", "15px" )
    , ( "background", "#fff" )
    , ( "padding", "15px" )
    , ( "boxShadow", "0px 0px 3px 0px rgba(0, 0, 0, 0.20)" )
    , ( "borderRadius", "3px" )
    ]


titleStyles : List ( String, String )
titleStyles =
    [ ( "fontSize", "22px" )
    , ( "color", "lightseagreen" )
    ]


noteStyles : List ( String, String )
noteStyles =
    List.append breakLongWords [ ( "marginTop", "7px" ) ]
