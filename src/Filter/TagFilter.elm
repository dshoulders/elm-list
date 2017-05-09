module Filter.TagFilter exposing (..)

import Msgs exposing (..)
import Html exposing (Html, div, text)
import Regex exposing (Regex, find, regex)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Models.Models exposing (Item)
import Styles.BaseStyles exposing (tagStyles, defaultColours)
import Styles.Utils exposing (mergeStyles)


view : String -> List Item -> Html Msg
view selectedTag items =
    div
        [ style filterStyles
        ]
        (items
            |> allTags
            |> List.map
                (\tag ->
                    div 
                        [ style (getTagStyle selectedTag tag)
                        , onClick (Msgs.TagSearch tag)
                        ]
                        [ text tag ]
                )
        )


allTags : List Item -> List String
allTags items =
    items
        |> List.foldl
            (\item acc ->
                acc
                    ++ (List.map .match
                            (find
                                Regex.All
                                (regex "\\B#\\w*[a-zA-Z]+\\w*")
                                item.notes
                            )
                       )
            )
            []
        |> List.foldl
            (\tag acc ->
                if List.member tag acc then
                    acc
                else
                    tag :: acc
            )
            []
        |> List.sort


getTagStyle : String -> String -> List ( String, String )
getTagStyle selectedTag tag =
    if tag == selectedTag then
        selectedTagStyles
    else
        deselectedTagStyles



-- Styles


filterStyles : List ( String, String )
filterStyles =
    [ ( "marginBottom", "8px" )
    , ( "display", "flex" )
    , ( "flexWrap", "wrap" )
    ]


deselectedTagStyles : List ( String, String )
deselectedTagStyles =
    mergeStyles
        [ tagStyles
        , [ ( "marginRight", "4px" )
          , ( "marginTop", "4px" )
          ]
        ]


selectedTagStyles : List ( String, String )
selectedTagStyles =
    mergeStyles
        [ deselectedTagStyles
        , [ ( "color", defaultColours.blue )
          ]
        ]
