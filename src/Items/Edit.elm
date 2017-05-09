module Items.Edit exposing (..)

import Html exposing (div, input, textarea, button, text, Html)
import Html.Attributes exposing (style, value, placeholder)
import Html.Events exposing (onClick, onInput)
import Msgs exposing (Msg)
import Models.Models exposing (Item, ItemId)
import Styles.Utils exposing (mergeStyles)
import Styles.BaseStyles exposing (defaultFontFamily, fontWeights, defaultColours, inputStyles, buttonStyles)


view : Item -> Html Msg
view item =
    div []
        [ input
            [ value item.title
            , style inputStyle
            , placeholder "Title"
            , onInput (Msgs.UpdateTempItem "title")
            ]
            []
        , textarea
            [ value item.notes
            , style textareaStyle
            , placeholder "Notes"
            , onInput (Msgs.UpdateTempItem "notes")
            ]
            []
        , div [ style actionStyle ]
            [ button [ style deleteStyle, onClick (Msgs.RemoveItem item.id) ] [ text "Delete" ]
            , button [ style cancelStyle, onClick (Msgs.ChangeLocation "/") ] [ text "Cancel" ]
            , button [ style saveStyle, onClick Msgs.SaveItem ] [ text "Save" ]
            ]
        ]



-- Styles


fontStyle : List ( String, String )
fontStyle =
    [ ( "fontFamily", defaultFontFamily )
    ]


inputStyle : List ( String, String )
inputStyle =
    mergeStyles
        [ inputStyles
        , [ ( "fontSize", "22px" )
          , ( "fontWeight", fontWeights.normal )
          ]
        ]


textareaStyle : List ( String, String )
textareaStyle =
    mergeStyles
        [ [ ( "fontSize", "16px" )
          , ( "padding", "5px 10px" )
          , ( "width", "100%" )
          , ( "height", "200px" )
          , ( "border", "none" )
          , ( "marginBottom", "15px" )
          ]
        , fontStyle
        ]


actionStyle : List ( String, String )
actionStyle =
    [ ( "display", "flex" )
    , ( "justifyContent", "flex-end" )
    ]


saveStyle : List ( String, String )
saveStyle =
    mergeStyles
        [ [ ( "marginLeft", "15px" ) ]
        , fontStyle
        , buttonStyles
        ]


cancelStyle : List ( String, String )
cancelStyle =
    mergeStyles
        [ fontStyle
        , buttonStyles
        , [ ( "background", "#808080" ) ]
        ]


deleteStyle : List ( String, String )
deleteStyle =
    mergeStyles
        [ fontStyle
        , buttonStyles
        , [ ( "background", "#c53434" )
          , ( "marginRight", "auto" )
          ]
        ]
