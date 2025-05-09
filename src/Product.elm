module Product exposing (Product, Variant)

import Array exposing (Array)


type alias Variant =
    { colorName : String
    , color : String
    , imageUrl : String
    , openedImageUrl : String
    , isNew : Bool
    }


type alias Product =
    { name : String
    , price : String
    , description : String
    , variants : Array Variant
    }
