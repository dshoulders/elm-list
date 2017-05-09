module Styles.BaseStyles exposing (..)


defaultFontFamily =
    "Open Sans"


fontWeights =
    { bold = "700"
    , semiBold = "600"
    , normal = "400"
    , light = "300"
    }


defaultColours =
    { darkGrey = "#3c3c3c"
    , lightBlue = "#e0e1ec"
    , blue = "#0087ff"
    }


inputStyles : List ( String, String )
inputStyles =
    [ ( "marginBottom", "15px" )
    , ( "padding", "5px 10px" )
    , ( "border", "none" )
    , ( "borderBottom", "1px solid #ccc" )
    , ( "fontFamily", defaultFontFamily )
    , ( "fontWeight", fontWeights.light )
    , ( "fontSize", "18px" )
    , ( "outline", "none" )
    , ( "width", "100%" )
    ]


buttonStyles : List ( String, String )
buttonStyles =
    [ ( "background", "#00bf83" )
    , ( "fontSize", "14px" )
    , ( "border", "0px" )
    , ( "borderRadius", "2px" )
    , ( "padding", "5px 10px" )
    , ( "cursor", "pointer" )
    , ( "color", "#fff" )
    ]


tagStyles : List ( String, String )
tagStyles =
    [ ( "color", "#ff9b00" )
    , ( "background", "whitesmoke" )
    , ( "padding", "0 5px" )
    , ( "borderRadius", "2px" )
    , ( "cursor", "pointer" )
    , ( "font-weight", fontWeights.normal )
    ]


breakLongWords : List ( String, String )
breakLongWords =
    [ -- These are technically the same, but use both
      ( "overflow-wrap", "break-word" )
    , ( "word-wrap", "break-word" )
    , ( "-ms-word-break", "break-all" )
    , -- This is the dangerous one in WebKit, as it breaks things wherever
      ( "word-break", "break-all" )
    , -- Instead use this non-standard one:
      ( "word-break", "break-word" )
    , -- Adds a hyphen where the word breaks, if supported (No Blink)
      ( "-ms-hyphens", "auto" )
    , ( "-moz-hyphens", "auto" )
    , ( "-webkit-hyphens", "auto" )
    , ( "hyphens", "auto" )
    ]
