module Main exposing (main)

import Browser
import Css
import Css.Global
import Css.Transitions
import Html
import Html.Attributes
import Html.Styled
import Html.Styled.Attributes
import Json.Decode


type alias Model =
    { events : List Event
    }


type alias Event =
    { title : String
    , description : String
    }


main =
    Browser.document
        { init = init
        , view = viewBody >> Browser.Document "Yiddish Calendar"
        , update = update
        , subscriptions = always Sub.none
        }


init : Json.Decode.Value -> ( Model, Cmd Never )
init _ =
    ( { events = List.repeat 66 { title = "Test Event", description = "Description" }
      }
    , Cmd.none
    )


update msg model =
    ( model
    , Cmd.none
    )


viewBody model =
    [ Html.Styled.toUnstyled
        (Css.Global.global
            [ Css.Global.html
                [ Css.height (Css.pct 100)
                , Css.overflow Css.hidden
                ]
            , Css.Global.body
                [ Css.height (Css.pct 100)
                , Css.margin Css.zero
                , Css.overflow Css.scroll
                , Css.fontFamilies [ "Arimo", Css.sansSerif.value ]
                ]
            ]
        )
    , Html.node "link"
        [ Html.Attributes.href "https://fonts.googleapis.com/css2?family=Arimo:wght@400;700&display=block"
        , Html.Attributes.rel "stylesheet"
        , Html.Attributes.type_ "text/css"
        ]
        []
    , Html.Styled.toUnstyled (viewContents model)
    ]


viewContents { events } =
    Html.Styled.div
        [ Html.Styled.Attributes.css
            [ Css.height (Css.pct 100)
            , Css.displayFlex
            , Css.flexDirection Css.column
            ]
        ]
        [ viewPaddedContainer
            H1
            Center
            [ Html.Styled.Attributes.css [ Css.flexShrink (Css.num 0) ] ]
            [ Html.Styled.text "Yiddish Calendar" ]
        , viewCalendar events
        , viewPaddedContainer
            H3
            Start
            [ Html.Styled.Attributes.css [ Css.flexShrink (Css.num 0) ] ]
            [ Html.Styled.text "Something Missing?"
            , Html.Styled.span
                [ Html.Styled.Attributes.css
                    [ Css.width (Css.px 16)
                    , Css.display Css.inlineBlock
                    ]
                ]
                []
            , viewButton "LET ME KNOW"
            ]
        ]


viewCalendar events =
    Html.Styled.div
        [ Html.Styled.Attributes.css
            [ Css.height (Css.pct 100)
            , Css.overflowY Css.scroll
            ]
        ]
        (List.concatMap viewEvent events)


viewEvent { title, description } =
    [ viewPaddedContainer Normal Start [] [ Html.Styled.div [] [ Html.Styled.text title ], Html.Styled.text description ]
    ]


type FontSize
    = H1
    | H2
    | H3
    | Normal


type Alignment
    = Center
    | Start


colorButton =
    Css.hex "#f9f9f9"


colorButtonFocus =
    Css.hex "#fadafd"


colorButtonHover =
    Css.hex "#f4b4fb"


colorButtonActive =
    Css.hex "#eaa0f6"


colorButtonText =
    Css.hex "#000000"


durationAnimationReaction =
    120


durationAnimationTransition =
    600


viewButton text =
    Html.Styled.a
        [ Html.Styled.Attributes.css
            [ Css.padding (Css.px 12)
            , Css.display Css.inlineBlock
            , Css.borderRadius (Css.px 8)
            , Css.backgroundColor colorButton
            , Css.color colorButtonText
            , Css.outline Css.none
            , Css.fontSize Css.large
            , Css.textDecoration Css.none
            , Css.focus
                [ Css.backgroundColor colorButtonFocus
                , Css.boxShadow4 Css.zero Css.zero (Css.px 6) colorButtonFocus
                ]
            , Css.hover
                [ Css.backgroundColor colorButtonHover
                , Css.boxShadow4 Css.zero Css.zero (Css.px 6) colorButtonHover
                ]
            , Css.active
                [ Css.backgroundColor colorButtonActive
                , Css.boxShadow4 Css.zero Css.zero (Css.px 4) colorButtonActive
                ]
            , Css.Transitions.transition
                [ Css.Transitions.boxShadow durationAnimationReaction
                , Css.Transitions.backgroundColor durationAnimationReaction
                ]
            ]
        , Html.Styled.Attributes.target "_blank"
        , Html.Styled.Attributes.href "mailto:balebos@yiddishcalendar.com"
        ]
        [ Html.Styled.text text ]


viewPaddedContainer fontSize alignment attrs elements =
    Html.Styled.div
        ([ Html.Styled.Attributes.css
            [ Css.width (Css.pct 100)
            , Css.boxSizing Css.borderBox
            , Css.padding (Css.px 16)
            , Css.fontSize
                (case fontSize of
                    H1 ->
                        Css.xxLarge

                    H2 ->
                        Css.xLarge

                    H3 ->
                        Css.large

                    Normal ->
                        Css.medium
                )
            , Css.textAlign
                (case alignment of
                    Center ->
                        Css.center

                    Start ->
                        Css.start
                )
            ]
         ]
            ++ attrs
        )
        elements
