module Main exposing (..)

import Browser
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


type Model
    = Failure
    | Loading
    | Success (List Product)


init : () -> ( Model, Cmd Msg )
init _ =
    ( Loading
    , fetchProducts
    )



-- UPDATE


type Msg
    = GotProducts (Result Http.Error (List Product))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg _ =
    case msg of
        GotProducts result ->
            case result of
                Ok productList ->
                    ( Success productList, Cmd.none )

                Err _ ->
                    ( Failure, Cmd.none )



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

        Success productList ->
            div [ class "container" ]
                [ h2 [ class "container__title" ] [ text "Traveling soon? These travel products will help." ]
                , div [ class "product-card-container" ] (List.map ProductCard.view productList)
                ]



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
