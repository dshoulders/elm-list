port module Ports exposing (..)

import Models.Models exposing (Item, ItemId)


port fetchList : String -> Cmd msg


port receiveList : (String -> msg) -> Sub msg


port saveItem : Item -> Cmd msg


port afterSaveItem : (Item -> msg) -> Sub msg


port removeItem : ItemId -> Cmd msg
