module Product exposing (Product, Variant)


type alias Variant =
    { colorName : String
    , imageUrl : String
    }


type alias Product =
    { name : String
    , price : String
    , description : String
    , variants : List Variant
    }
