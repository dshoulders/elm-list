module Update.Update exposing (..)

import Msgs exposing (Msg)
import Update.Reducers as Reducers
import Models.Models exposing (Model)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Msgs.OnReceiveList response ->
            Reducers.receiveList model response

        Msgs.SaveItem ->
            Reducers.saveItem model

        Msgs.AfterSaveItem item ->
            Reducers.afterSaveItem model item

        Msgs.RemoveItem itemId ->
            Reducers.removeItem model itemId

        Msgs.ChangeLocation path ->
            Reducers.changeLocation model path

        Msgs.OnLocationChange location ->
            Reducers.locationChange model location

        Msgs.UpdateTempItem propName value ->
            Reducers.updateTempItem model propName value

        Msgs.TextSearch searchText ->
            Reducers.textSearch model searchText

        Msgs.TagSearch tag ->
            Reducers.tagSearch model tag

        Msgs.ClearFilter ->
            Reducers.clearFilter model
