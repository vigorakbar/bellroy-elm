module ProductCard exposing (..)

import Array
import Html exposing (Html, button, div, img, p, text)
import Html.Attributes exposing (class, classList, src, style, title)
import Html.Events exposing (onClick)
import Product exposing (Product, Variant)



-- MODEL


type alias Model =
    { product : Product
    , selectedVariantIndex : Int
    , showingInside : Bool
    }


init : Product -> Model
init product =
    { product = product
    , selectedVariantIndex = 0
    , showingInside = False
    }



-- UPDATE


type Msg
    = SelectVariant Int
    | ToggleInsideView


update : Msg -> Model -> Model
update msg model =
    case msg of
        SelectVariant index ->
            { model | selectedVariantIndex = index }

        ToggleInsideView ->
            { model | showingInside = not model.showingInside }



-- VIEW


view : Model -> Html Msg
view model =
    let
        selectedVariant =
            Maybe.withDefault
                { colorName = "", color = "#FFFFFF", imageUrl = "", openedImageUrl = "", isNew = False }
                (Array.get model.selectedVariantIndex model.product.variants)

        currentImageUrl =
            if model.showingInside then
                selectedVariant.openedImageUrl

            else
                selectedVariant.imageUrl

        toggleButtonText =
            if model.showingInside then
                "Close ×"

            else
                "Show Inside +"
    in
    div [ class "product-card" ]
        [ div [ class "product-card__image" ]
            [ div [ class "product-card__image-outer" ]
                [ div [ class "product-card__image-inner" ]
                    [ img
                        [ class "product-card__image-element"
                        , src currentImageUrl
                        ]
                        []
                    ]
                ]
            , button
                [ class "product-card__toggle-inside-button"
                , onClick ToggleInsideView
                ]
                [ text toggleButtonText ]
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
            (Array.indexedMap (viewColorPickerButton model.selectedVariantIndex) model.product.variants |> Array.toList)
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
