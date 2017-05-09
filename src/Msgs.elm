module Msgs exposing (..)

import Models.Models exposing (Item, ItemId)
import Navigation exposing (Location)


type Msg
    = OnReceiveList String
    | ChangeLocation String
    | OnLocationChange Location
    | UpdateTempItem String String
    | RemoveItem ItemId
    | SaveItem
    | AfterSaveItem Item
    | TextSearch String
    | TagSearch String
    | ClearFilter
