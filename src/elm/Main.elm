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


main =
    Browser.document
        { init = init
        , view = viewBody >> Browser.Document "Yiddish Calendar"
        , update = always (always ( (), Cmd.none ))
        , subscriptions = always Sub.none
        }


init : Json.Decode.Value -> ( (), Cmd Never )
init _ =
    ( (), Cmd.none )


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


viewContents _ =
    Html.Styled.div
        [ Html.Styled.Attributes.css
            [ Css.height (Css.pct 100)
            , Css.displayFlex
            , Css.flexDirection Css.column
            ]
        ]
        [ viewPaddedContainer Title Center [ Html.Styled.text "Yiddish Calendar" ]
        , Html.Styled.iframe
            [ Html.Styled.Attributes.src "https://calendar.google.com/calendar/embed?src=kk0idu5gnn5thvoccqrocvmaag%40group.calendar.google.com&ctz=America%2FNew_York&showTitle=0&showNav=0&showDate=0&showPrint=0&showCalendars=0&mode=AGENDA"
            , Html.Styled.Attributes.css
                [ Css.border Css.zero
                , Css.width (Css.pct 100)
                , Css.height (Css.pct 100)
                , Css.display Css.block
                ]
            ]
            []
        , viewPaddedContainer
            Subtitle
            Start
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


type FontSize
    = Title
    | Subtitle


type Alignment
    = Center
    | Start


colorButton =
    Css.hex "#f9f9f9"


colorButtonHover =
    Css.hex "#f4b4fb"


colorButtonPress =
    Css.hex "#eaa0f6"


durationReactionAnimation =
    120


viewButton text =
    Html.Styled.button
        [ Html.Styled.Attributes.css
            [ Css.padding (Css.px 12)
            , Css.borderRadius (Css.px 8)
            , Css.backgroundColor colorButton
            , Css.color Css.inherit
            , Css.cursor Css.pointer
            , Css.outline Css.none
            , Css.border Css.zero
            , Css.fontSize Css.large
            , Css.fontFamily Css.inherit
            , Css.hover
                [ Css.backgroundColor colorButtonHover
                , Css.boxShadow4 Css.zero Css.zero (Css.px 6) colorButtonHover
                ]
            , Css.focus
                [ Css.backgroundColor colorButtonHover
                , Css.boxShadow4 Css.zero Css.zero (Css.px 6) colorButtonHover
                ]
            , Css.active
                [ Css.backgroundColor colorButtonPress
                , Css.boxShadow4 Css.zero Css.zero (Css.px 4) colorButtonPress
                ]
            , Css.Transitions.transition
                [ Css.Transitions.boxShadow durationReactionAnimation
                , Css.Transitions.backgroundColor durationReactionAnimation
                ]
            ]
        ]
        [ Html.Styled.text text ]


viewPaddedContainer fontSize alignment elements =
    Html.Styled.div
        [ Html.Styled.Attributes.css
            [ Css.width (Css.pct 100)
            , Css.boxSizing Css.borderBox
            , Css.padding (Css.px 16)
            , Css.fontSize
                (case fontSize of
                    Title ->
                        Css.xxLarge

                    Subtitle ->
                        Css.large
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
        elements
