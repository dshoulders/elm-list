module Update.Reducers exposing (..)

import Models.Models exposing (Model, Item, ItemId, Route(..))
import Routing exposing (parseLocation)
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required)
import Navigation exposing (Location, newUrl)
import Ports


-- Reducers


locationChange : Model -> Location -> ( Model, Cmd msg )
locationChange model location =
    let
        newModel =
            modelForRoute (parseLocation location) model
    in
        ( newModel, Cmd.none )


receiveList : Model -> String -> ( Model, Cmd msg )
receiveList model response =
    let
        parseItemsResult =
            parseList response
    in
        case parseItemsResult of
            Result.Err err ->
                ( { model | items = [] }, Cmd.none )

            Result.Ok parsedItems ->
                let
                    newTempItem =
                        getItemForEdit model.tempItem.id parsedItems

                    newVisibleItemIds =
                        parsedItems
                            |> List.map (\item -> item.id)
                in
                    ( { model
                        | items = parsedItems
                        , tempItem = newTempItem
                        , visibleItemIds = newVisibleItemIds
                      }
                    , Cmd.none
                    )


updateTempItem : Model -> String -> String -> ( Model, Cmd msg )
updateTempItem model propName value =
    let
        newTempItem =
            updateItem propName value model.tempItem
    in
        ( { model | tempItem = newTempItem }, Cmd.none )


saveItem : Model -> ( Model, Cmd msg )
saveItem model =
    let
        newItems =
            model.items
                |> List.map
                    (\item ->
                        if item.id == model.tempItem.id then
                            model.tempItem
                        else
                            item
                    )
    in
        ( { model | items = newItems }, Ports.saveItem model.tempItem )


afterSaveItem : Model -> Item -> ( Model, Cmd msg )
afterSaveItem model item =
    let
        newTempItem =
            Item "" "" ""

        maybeExistingItem =
            model.items
                |> List.filter (\itemToCheck -> itemToCheck.id == item.id)
                |> List.head
    in
        case maybeExistingItem of
            Just existingItem ->
                ( { model | tempItem = newTempItem }, newUrl "/" )

            Nothing ->
                let
                    newItems =
                        item :: model.items

                    newVisibleItemIds =
                        newItems
                            |> mapId
                in
                    ( { model
                        | items = newItems
                        , tempItem = newTempItem
                        , visibleItemIds = newVisibleItemIds
                      }
                    , newUrl "/"
                    )


removeItem : Model -> ItemId -> ( Model, Cmd msg )
removeItem model itemId =
    let
        newItems =
            model.items
                |> List.filter
                    (\item -> item.id /= itemId)

        newVisibleItemIds =
            model.items
                |> mapId

        newTempItem =
            Item "" "" ""
    in
        ( { model
            | items = newItems
            , visibleItemIds = newVisibleItemIds
            , tempItem = newTempItem
          }
        , Cmd.batch [ newUrl "/", Ports.removeItem itemId ]
        )


textSearch : Model -> String -> ( Model, Cmd msg )
textSearch model searchText =
    let
        newVisibleItemIds =
            model.items
                |> List.filter
                    (\item ->
                        if String.isEmpty searchText then
                            True
                        else
                            String.contains (String.toLower searchText) (String.toLower item.title)
                    )
                |> mapId
    in
        ( { model | searchText = searchText, visibleItemIds = newVisibleItemIds }, Cmd.none )


tagSearch : Model -> String -> ( Model, Cmd msg )
tagSearch model tag =
    let
        newVisibleItemIds =
            model.items
                |> List.filter
                    (\item ->
                        if String.contains tag item.notes then
                            True
                        else
                            False
                    )
                |> mapId
    in
        ( { model | searchText = "", visibleItemIds = newVisibleItemIds }, Cmd.none )


clearFilter : Model -> ( Model, Cmd msg )
clearFilter model =
    let
        newVisibleItemIds =
            model.items
                |> mapId
    in
        ( { model | searchText = "", visibleItemIds = newVisibleItemIds }, Cmd.none )


changeLocation : Model -> String -> ( Model, Cmd msg )
changeLocation model path =
    ( model, newUrl path )



-- Utils


mapId : List { b | id : a } -> List a
mapId =
    List.map (\a -> a.id)


modelForRoute : Route -> Model -> Model
modelForRoute route model =
    case route of
        ItemNewRoute ->
            { model | route = route }

        ItemEditRoute itemId ->
            { model | route = route, tempItem = getItemForEdit itemId model.items }

        ItemBrowserRoute ->
            { model | route = route }

        LoginRoute ->
            { model | route = route }

        NotFoundRoute ->
            { model | route = route }


updateItem : String -> String -> Item -> Item
updateItem propName value item =
    if propName == "title" then
        { item | title = value }
    else if propName == "notes" then
        { item | notes = value }
    else
        item


parseList : String -> Result String (List Item)
parseList json =
    Decode.decodeString listDecoder json


listDecoder : Decode.Decoder (List Item)
listDecoder =
    Decode.keyValuePairs itemDecoder
        |> Decode.map (\a -> List.map (\( id, item ) -> item) a)


itemDecoder : Decode.Decoder Item
itemDecoder =
    decode Item
        |> required "id" Decode.string
        |> required "title" Decode.string
        |> required "notes" Decode.string


getItemForEdit : ItemId -> List Item -> Item
getItemForEdit itemId items =
    items
        |> List.filter (\item -> item.id == itemId)
        |> List.head
        |> (\maybeItem ->
                case maybeItem of
                    Maybe.Just item ->
                        item

                    Maybe.Nothing ->
                        Item itemId "" ""
           )
