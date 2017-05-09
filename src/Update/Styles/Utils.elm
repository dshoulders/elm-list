module Styles.Utils exposing (..)


mergeStyleIntoList : ( a, b ) -> List ( a, b ) -> List ( a, b )
mergeStyleIntoList ( prop, val ) list =
    List.foldl
        (\( listProp, listVal ) acc ->
            if listProp == prop then
                acc
            else
                ( listProp, listVal ) :: acc
        )
        [ ( prop, val ) ]
        list


mergeTwoStyleLists : List ( a, b ) -> List ( a, b ) -> List ( a, b )
mergeTwoStyleLists list1 list2 =
    case list2 of
        [] ->
            list1

        firstStyle :: restStyles ->
            mergeTwoStyleLists (mergeStyleIntoList firstStyle list1) restStyles


mergeStyles : List (List ( a, b )) -> List ( a, b )
mergeStyles styleLists =
    styleLists
        |> List.foldr mergeTwoStyleLists []
