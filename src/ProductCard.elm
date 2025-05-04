module ProductCard exposing (..)

import Html exposing (Html, div, text)
import Html.Attributes exposing (class)
import List exposing (product)
import Product exposing (Product)



-- Model


type alias Model =
    Maybe Product



-- Update
-- View


view : Maybe Product -> Html a
view maybeProduct =
    case maybeProduct of
        Just product ->
            div [ class "product_card" ]
                [ div [ class "product-card__image" ] []
                , div [ class "product-card__label" ] []
                , div [ class "product-card__main-info" ]
                    [ div [] [ text product.name ]
                    , div [ class "product-card__price" ] [ text product.price ]
                    ]
                , div [ class "product-card__color-picker" ] []
                , div [ class "product-card__description" ] [ text product.description ]
                ]

        Nothing ->
            text ""
