module ProductCard exposing (..)

import Html exposing (Html, button, div, img, p, text)
import Html.Attributes exposing (class, classList, style, title)
import List exposing (product)
import Product exposing (Product, Variant)



-- Model
-- Update
-- View


view : Product -> Html a
view product =
    div [ class "product-card" ]
        [ div [ class "product-card__image" ]
            [ div [ class "product-card__image-outer" ]
                [ div [ class "product-card__image-inner" ]
                    [ img [ class "product-card__image-element" ] [] ]
                ]
            ]
        , div [ class "product-card__label" ] []
        , div [ class "product-card__main-info" ]
            [ div [] [ text product.name ]
            , div [ class "product-card__price" ] [ text product.price ]
            ]
        , div [ class "product-card__color-picker" ] (List.map viewColorPickerButton product.variants)
        , div [ class "product-card__description" ] [ p [ class "product-card__description-text" ] [ text product.description ] ]
        ]


viewColorPickerButton : Variant -> Html a
viewColorPickerButton variant =
    button
        [ style "background-color" variant.color
        , style "border" ("1px solid " ++ variant.color)
        , title variant.colorName
        , classList
            [ ( "color-picker-button", True )
            , ( "color-picker-button__active", True ) -- TODO: set active when clicked
            ]
        ]
        []



-- Util
