module ProductCard exposing (..)

import Html exposing (Html, button, div, img, p, text)
import Html.Attributes exposing (class, classList, src, style, title)
import Html.Events exposing (onClick)
import Product exposing (Product, Variant)



-- MODEL


type alias Model =
    { product : Product
    , selectedVariantIndex : Int
    }


init : Product -> Model
init product =
    { product = product
    , selectedVariantIndex = 0 -- Default to first variant
    }



-- UPDATE


type Msg
    = SelectVariant Int


update : Msg -> Model -> Model
update msg model =
    case msg of
        SelectVariant index ->
            { model | selectedVariantIndex = index }



-- VIEW


view : Model -> Html Msg
view model =
    let
        selectedVariant =
            case List.drop model.selectedVariantIndex model.product.variants of
                first :: _ ->
                    first

                [] ->
                    -- Fallback in case of empty variants list
                    { colorName = "", color = "#FFFFFF", imageUrl = "", openedImageUrl = "", isNew = False }
    in
    div [ class "product-card" ]
        [ div [ class "product-card__image" ]
            [ div [ class "product-card__image-outer" ]
                [ div [ class "product-card__image-inner" ]
                    [ img
                        [ class "product-card__image-element"
                        , src selectedVariant.imageUrl
                        ]
                        []
                    ]
                ]
            , div [ class "product-card__label" ]
                [ if selectedVariant.isNew then
                    div [ class "product-card__new-label" ] [ text "New Color" ]

                  else
                    text ""
                ]
            ]
        , div [ class "product-card__main-info" ]
            [ div [] [ text model.product.name ]
            , div [ class "product-card__price" ] [ text model.product.price ]
            ]
        , div [ class "product-card__color-picker" ]
            (List.indexedMap (viewColorPickerButton model.selectedVariantIndex) model.product.variants)
        , div [ class "product-card__description" ]
            [ p [ class "product-card__description-text" ] [ text model.product.description ] ]
        ]


viewColorPickerButton : Int -> Int -> Variant -> Html Msg
viewColorPickerButton selectedIndex index variant =
    button
        [ style "background-color" variant.color
        , style "border" ("1px solid " ++ variant.color)
        , title variant.colorName
        , classList
            [ ( "color-picker-button", True )
            , ( "color-picker-button__active", selectedIndex == index )
            ]
        , onClick (SelectVariant index)
        ]
        []



-- HELPER FUNCTION FOR MAIN MODULE


viewProductCard : Product -> Html Msg
viewProductCard product =
    view (init product)
