module Main exposing (..)

import Browser
import Dict exposing (Dict)
import Html exposing (Html, div, h2, text)
import Html.Attributes exposing (class)
import Http
import Json.Decode as Decode
import Product exposing (Product, Variant)
import ProductCard



-- MAIN


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }



-- MODEL


type alias ProductCardModel =
    { products : List Product
    , productCards : Dict Int ProductCard.Model
    }


type Model
    = Failure
    | Loading
    | Success ProductCardModel


init : () -> ( Model, Cmd Msg )
init _ =
    ( Loading
    , fetchProducts
    )



-- UPDATE


type Msg
    = GotProducts (Result Http.Error (List Product))
    | ProductCardMsg Int ProductCard.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotProducts result ->
            case result of
                Ok productList ->
                    let
                        initialProductCards =
                            List.indexedMap (\idx product -> ( idx, ProductCard.init product )) productList
                                |> Dict.fromList
                    in
                    ( Success
                        { products = productList
                        , productCards = initialProductCards
                        }
                    , Cmd.none
                    )

                Err _ ->
                    ( Failure, Cmd.none )

        ProductCardMsg index subMsg ->
            case model of
                Success productCardModel ->
                    case Dict.get index productCardModel.productCards of
                        Just cardModel ->
                            let
                                updatedCardModel =
                                    ProductCard.update subMsg cardModel

                                updatedCards =
                                    Dict.insert index updatedCardModel productCardModel.productCards
                            in
                            ( Success { productCardModel | productCards = updatedCards }, Cmd.none )

                        Nothing ->
                            ( model, Cmd.none )

                _ ->
                    ( model, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    case model of
        Failure ->
            text "Failed to fetch products."

        Loading ->
            text "Loading..."

        Success productCardModel ->
            div [ class "container" ]
                [ h2 [ class "container__title" ] [ text "Traveling soon? These travel products will help." ]
                , div [ class "product-card-container" ]
                    (List.indexedMap viewProductCard (Dict.toList productCardModel.productCards))
                ]


viewProductCard : Int -> ( Int, ProductCard.Model ) -> Html Msg
viewProductCard _ ( index, cardModel ) =
    Html.map (ProductCardMsg index) (ProductCard.view cardModel)



-- HTTP


fetchProducts : Cmd Msg
fetchProducts =
    Http.get
        { url = "./products.json"
        , expect = Http.expectJson GotProducts productsDecoder
        }


productsDecoder : Decode.Decoder (List Product)
productsDecoder =
    Decode.list
        (Decode.map4 Product
            (Decode.field "name" Decode.string)
            (Decode.field "price" Decode.string)
            (Decode.field "description" Decode.string)
            (Decode.field "variants" (Decode.list variantDecoder))
        )


variantDecoder : Decode.Decoder Variant
variantDecoder =
    Decode.map5 Variant
        (Decode.field "colorName" Decode.string)
        (Decode.field "color" Decode.string)
        (Decode.field "imageUrl" Decode.string)
        (Decode.field "openedImageUrl" Decode.string)
        (Decode.field "isNew" Decode.bool)
