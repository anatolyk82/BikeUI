import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.VirtualKeyboard 2.1
import QtQuick.VirtualKeyboard.Styles 2.1

KeyboardStyle {
    id: currentStyle

    readonly property bool compactSelectionList: [InputEngine.Pinyin, InputEngine.Cangjie, InputEngine.Zhuyin].indexOf(InputContext.inputEngine.inputMode) !== -1
    readonly property string fontFamily: Style.lightFontName
    readonly property real keyBackgroundMargin: Math.round(1 * scaleHint)
    readonly property real keyContentMargin: Math.round(45 * scaleHint)
    readonly property real keyIconScale: scaleHint
    readonly property int  keyIconWidth: 64
    readonly property int  keyIconHeight: 64
    readonly property string resourcePrefix: "qrc:/QtQuick/VirtualKeyboard/content/styles/volvo/"

    readonly property string inputLocale: InputContext.locale
    property color inputLocaleIndicatorColor: "white"
    property QtObject inputLocaleIndicatorHighlightTimer: Timer {
        interval: 1000
        onTriggered: inputLocaleIndicatorColor = "gray"
    }
    property bool alternateKeysVisible: false
    readonly property int latinMode4RowsKeyboardHeight: 332

    property var layoutLabels: {
        "ar_AE": "label_button_s_l_change_language_arabic",
        "bg_BG": "label_button_s_l_change_language_bulgarian",
        "cs_CZ": "label_button_s_l_change_language_czech",
        "da_DK": "label_button_s_l_change_language_danish",
        "nl_NL": "label_button_s_l_change_language_dutch",
        "en_AU": "label_button_s_l_change_language_english_au",
        "en_GB": "label_button_s_l_change_language_english_uk",
        "en_US": "label_button_s_l_change_language_english_us",
        "et_EE": "label_button_s_l_change_language_estonian",
        "fi_FI": "label_button_s_l_change_language_finnish",
        "nl_BE": "label_button_s_l_change_language_flemish",
        "fr_CA": "label_button_s_l_change_language_french_canadian",
        "fr_FR": "label_button_s_l_change_language_french_eu",
        "de_DE": "label_button_s_l_change_language_german",
        "el_GR": "label_button_s_l_change_language_greek",
        "hu_HU": "label_button_s_l_change_language_hungarian",
        "it_IT": "label_button_s_l_change_language_italian",
        "ja_JP@Romaji":	"label_button_s_l_change_language_jp_romaji",
        "ja_JP": "label_button_s_l_change_language_jp_kana",
        "ko_KR": "label_button_s_l_change_language_korean",
        "lv_LV": "label_button_s_l_change_language_latvian",
        "lt_LT": "label_button_s_l_change_language_lithuanian",
        "nb_NO": "label_button_s_l_change_language_norwegian",
        "pl_PL": "label_button_s_l_change_language_polish",
        "pt_BR": "label_button_s_l_change_language_portuguese_eu",
        "pt_PT": "label_button_s_l_change_language_portuguese_brazilian",
        "ro_RO": "label_button_s_l_change_language_romanian",
        "ru_RU": "label_button_s_l_change_language_russian",
        "sk_SK": "label_button_s_l_change_language_slovakian",
        "sl_SI": "label_button_s_l_change_language_slovenian",
        "es_ES": "label_button_s_l_change_language_spanish_eu",
        "es_MX": "label_button_s_l_change_language_spanish_us",
        "sv_SE": "label_button_s_l_change_language_swedish",
        "zh_CN": "label_button_s_l_change_language_ch_s_stroke",
        "zh_CN@Pinyin": "label_button_s_l_change_language_ch_s_pinyin",
        "zh_HK": "label_button_s_l_change_language_ch_t_stroke",
        "zh_TW": "label_button_s_l_change_language_tw_zhuyin",
        "tr_TR": "label_button_s_l_change_language_turkish"
    }

    onInputLocaleChanged: {
        inputLocaleIndicatorColor = "white";
        inputLocaleIndicatorHighlightTimer.restart();
    }

    rowHeight: 80
    latinModeDesignHeight: (currentRowsCount <= 4)? latinMode4RowsKeyboardHeight : (latinMode4RowsKeyboardHeight + ((currentRowsCount - 4) * rowHeight))
    keyboardDesignWidth: 768
    keyboardDesignHeight: latinModeDesignHeight
    keyboardHWRDesignHeight: 411
    keyboardRelativeLeftMargin: 7 / keyboardDesignWidth
    keyboardRelativeRightMargin: 7 / keyboardDesignWidth
    keyboardRelativeTopMargin: 2 / keyboardDesignHeight
    keyboardRelativeBottomMargin: 10 / keyboardDesignHeight

    keyboardBackground: Item {
        Image {
            anchors.fill: parent
            source: "images/9patch_keyboardbg.png"
            fillMode: Image.Stretch
        }
    }

    keyPanel: KeyPanel {
        id: keyPanel

        KeyBackground {
            id: keyBackground

            alternateKeysVisible: currentStyle.alternateKeysVisible

            Text {
                id: keyText
                anchors.fill: parent
                anchors.leftMargin: keyContentMargin
                anchors.topMargin: control.smallTextVisible ? keyContentMargin * 1.2 : keyContentMargin
                anchors.rightMargin: keyContentMargin
                anchors.bottomMargin: control.smallTextVisible ? keyContentMargin * 0.8 : keyContentMargin
                text: control.displayText
                color: "white"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font {
                    family: fontFamily
                    weight: Font.Light
                    pixelSize: 32 * scaleHint
                    capitalization: control.uppercased ? Font.AllUppercase : Font.MixedCase
                }
            }
        }
        states: [
            State {
                name: "pressed"
                when: control.pressed
                PropertyChanges { target: keyBackground; highlight: true }
                PropertyChanges { target: keyText; opacity: 0 }
            },
            State {
                name: "disabled"
                when: !control.enabled
                PropertyChanges { target: keyBackground; highlight: false }
            }
        ]
    }

    backspaceKeyPanel: KeyPanel {
        SpecialKeyBackground {
            id: backspaceKeyBackground
            Image {
                id: backspaceKeyIcon
                anchors.centerIn: parent
                sourceSize.width: keyIconWidth * keyIconScale
                sourceSize.height: keyIconHeight * keyIconScale
                fillMode: Image.Stretch
                smooth: false
                source: resourcePrefix + (InputContext.locale === "ar_AE" ? "images/ic_btn_erasealt.png" : "images/ic_btn_erase.png")
            }
        }
        states: [
            State {
                name: "pressed"
                when: control.pressed
                PropertyChanges { target: backspaceKeyBackground; highlight: true }
            },
            State {
                name: "disabled"
                when: !control.enabled
                PropertyChanges { target: backspaceKeyBackground; highlight: false }
            }
        ]
    }

    languageKeyPanel: KeyPanel {
        SpecialKeyBackground {
            id: languageKeyBackground
            clip: true

            Label {
                id: languageKeyText
                anchors.centerIn: parent
                text: layoutLabels[InputContext.locale]
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 32 * scaleHint
            }
        }
        states: [
            State {
                name: "pressed"
                when: control.pressed
                PropertyChanges { target: languageKeyBackground; highlight: true }
            },
            State {
                name: "disabled"
                when: !control.enabled
                PropertyChanges { target: languageKeyBackground; highlight: false }
            }
        ]
    }

    enterKeyPanel: KeyPanel {
        SpecialKeyBackground {
            id: enterKeyBackground
            clip: true

            Image {
                id: enterKeyIcon

                anchors.centerIn: parent
                visible: (enterKeyText.text.length === 0) &&
                         (control.actionId === ApplicationHelper.actionEnterKey)

                sourceSize.width: keyIconWidth * keyIconScale
                sourceSize.height: keyIconHeight * keyIconScale
                smooth: false
                fillMode: Image.Stretch
                source: resourcePrefix + "images/ic_btn_enter.png"
                Behavior on opacity { NumberAnimation { duration: 300 } }
            }

            Label {
                id: enterKeyText
                anchors.centerIn: parent
                visible: control.actionId !== ApplicationHelper.actionEnterKey
                text: {
                    switch (control.actionId) {
                    case ApplicationHelper.actionOkKey:
                        return "label_button_keyboard_ok"
                    case ApplicationHelper.actionDoneKey:
                        return "label_button_keyboard_done"
                    case ApplicationHelper.actionSearchKey:
                        return "label_button_keyboard_search"
                    case ApplicationHelper.actionSendKey:
                        return "label_button_keyboard_send"
                    case ApplicationHelper.actionEnterKey:
                        return ""
                    default:
                        return ""
                    }
                }
                font.pixelSize: 32 * scaleHint
            }
        }
        states: [
            State {
                name: "pressed"
                when: control.pressed
                PropertyChanges { target: enterKeyBackground; highlight: true }
                PropertyChanges { target: enterKeyIcon; opacity: 1.0 }
                PropertyChanges { target: enterKeyText; color: "white" }
            },
            State {
                name: "disabled"
                when: !control.enabled
                PropertyChanges { target: enterKeyBackground; highlight: false }
                PropertyChanges { target: enterKeyIcon; opacity: 0.4 }
                PropertyChanges { target: enterKeyText; color: "gray" }
            }
        ]
    }

    shiftKeyPanel: KeyPanel {
        SpecialKeyBackground {
            id: shiftKeyBackground
            Image {
                id: shiftKeyIcon
                anchors.centerIn: parent
                sourceSize.width: keyIconWidth * keyIconScale
                sourceSize.height: keyIconHeight * keyIconScale
                smooth: false
                fillMode: Image.Stretch
                source: resourcePrefix + "images/ic_btn_shift.png"
            }
            states: [
                State {
                    name: "capslock"
                    when: InputContext.capsLock
                    PropertyChanges { target: shiftKeyIcon; source: resourcePrefix + "images/ic_btn_shiftdouble.png" }
                },
                State {
                    name: "shift"
                    when: InputContext.shift
                    PropertyChanges { target: shiftKeyIcon; source: resourcePrefix + "images/ic_btn_shiftsingle.png" }
                }
            ]
        }
        states: [
            State {
                name: "pressed"
                when: control.pressed
                PropertyChanges { target: shiftKeyBackground; highlight: true }
            },
            State {
                name: "disabled"
                when: !control.enabled
                PropertyChanges { target: shiftKeyBackground; highlight: false }
            }
        ]
    }

    spaceKeyPanel: KeyPanel {
        KeyBackground {
            id: spaceKeyBackground
        }

        Label {
            id: spaceKeyText
            anchors.centerIn: parent
            text: "label_button_keyboard_space"
            font.pixelSize: 32 * scaleHint
        }

        states: [
            State {
                name: "pressed"
                when: control.pressed
                PropertyChanges { target: spaceKeyBackground; highlight: true }
            },
            State {
                name: "disabled"
                when: !control.enabled
                PropertyChanges { target: spaceKeyBackground; highlight: false }
            }
        ]
    }

    symbolKeyPanel: KeyPanel {
        SpecialKeyBackground {
            id: symbolKeyBackground

            Label {
                id: symbolKeyText
                anchors.centerIn: parent
                text: keyboard.symbolMode ? "label_button_keyboard_alphabet" : "label_button_keyboard_number"
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 32 * scaleHint
            }
        }

        states: [
            State {
                name: "pressed"
                when: control.pressed
                PropertyChanges { target: symbolKeyBackground; highlight: true }
            },

            State {
                name: "disabled"
                when: !control.enabled
                PropertyChanges { target: symbolKeyBackground; highlight: false }
            }
        ]
    }

    modeKeyPanel: KeyPanel {
        SpecialKeyBackground {
            id: modeKeyBackground

            Label {
                id: modeKeyText
                anchors.centerIn: parent
                text: control.displayText
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 32 * scaleHint
            }

            Image {
                id: modeKeyIcon
                anchors.centerIn: parent
                sourceSize.width: keyIconWidth * keyIconScale
                sourceSize.height: keyIconHeight * keyIconScale
                smooth: false
                fillMode: Image.Stretch
                visible: control.displayText === ""
                source: resourcePrefix + "images/ic_btn_level_2.png"
            }
        }

        states: [
            State {
                name: "pressed"
                when: control.pressed
                PropertyChanges { target: modeKeyBackground; highlight: true }
            },
            State {
                name: "disabled"
                when: !control.enabled
                PropertyChanges { target: modeKeyBackground; highlight: false }
            }
        ]
    }

    handwritingKeyPanel: KeyPanel {
        SpecialKeyBackground {
            id: hwrKeyBackground

            Image {
                id: hwrKeyIcon
                anchors.centerIn: parent
                sourceSize.width: keyIconWidth * keyIconScale
                sourceSize.height: keyIconHeight * keyIconScale
                smooth: false
                fillMode: Image.Stretch
                source: control.handwritingMode ? "" : resourcePrefix + "images/ic_btn_scribble.png"
            }
        }
        states: [
            State {
                name: "pressed"
                when: control.pressed
                PropertyChanges { target: hwrKeyBackground; highlight: true }
            },
            State {
                name: "disabled"
                when: !control.enabled
                PropertyChanges { target: hwrKeyBackground; highlight: false }
            }
        ]
    }

    keyboardModeKeyPanel: KeyPanel {
        SpecialKeyBackground {
            id: keyboardModeKeyBackground

            Image {
                id: keyboardModeKeyIcon
                anchors.centerIn: parent
                sourceSize.width: keyIconWidth * keyIconScale
                sourceSize.height: keyIconHeight * keyIconScale
                smooth: false
                fillMode: Image.Stretch
                opacity: keyboard.mainLayoutEnabled ? 1.0 : Style.disabledOpacity
                source: resourcePrefix + "images/ic_btn_keyboard.png"
            }
        }

        states: [
            State {
                name: "pressed"
                //when: control.pressed
                PropertyChanges { target: keyboardModeKeyBackground; highlight: true }
            },
            State {
                name: "disabled"
                //when: !control.enabled
                PropertyChanges { target: keyboardModeKeyBackground; highlight: false }
            }
        ]
    }

    characterPreviewMargin: -10

    characterPreviewDelegate: Item {
        id: characterPreview

        property string text

        BorderImage {
            anchors.fill: parent
            source: currentStyle.resourcePrefix + "images/9patch_3Dbtn_Keyboard_PRS.png"
            border.left: 9; border.right: 9;
            border.top: 10; border.bottom: 10;

            Text {
                id: characterPreviewText
                anchors.top: parent.top
                anchors.topMargin: (parent.height / 8)
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.margins: Math.round(48 * scaleHint)
                color: "white"
                text: characterPreview.text
                fontSizeMode: Text.HorizontalFit
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font {
                    family: fontFamily
                    weight: Font.Normal
                    pixelSize: 42 * scaleHint
                }
            }
        }
    }

    alternateKeysListBottomMargin: -1
    alternateKeysListItemWidth: 68 * scaleHint
    alternateKeysListItemHeight: 67 * scaleHint
    //alternateKeyScale: 1.0
    alternateKeysListDelegate: Item {
        id: alternateKeysListItem
        width: alternateKeysListItemWidth * alternateKeyScale
        height: alternateKeysListItemHeight

        Text {
            id: listItemText
            anchors.centerIn: parent
            text: model.text
            color: "white"
            font {
                family: fontFamily
                weight: Font.Normal
                pixelSize: 42 * scaleHint * alternateKeyScale
            }
        }
    }

    alternateKeysListHighlight: Rectangle {
        color: "#3f959595"
        radius: 0
    }

    alternateKeysListBackground: BorderImage {
        source: currentStyle.resourcePrefix + "images/9patch_3Dbtn_Keyboard_HPRS2.png";
        border.left: 9; border.right: 9;
        border.top: 10; border.bottom: 10;
        anchors.fill: parent
    }

    selectionListHeight: 80 * scaleHint

    selectionListDelegate: SelectionListItem {
        id: selectionListItem
        width: Math.round(selectionListLabel.width + selectionListLabel.anchors.leftMargin * 2)

        Text {
            id: selectionListLabel
            anchors.left: parent.left
            anchors.leftMargin: Math.round((compactSelectionList ? 50 : 140) * scaleHint)
            anchors.verticalCenter: parent.verticalCenter
            text: decorateText(display, wordCompletionLength)
            color: "#80c342"
            font {
                family: fontFamily
                weight: Font.Normal
                pixelSize: 44 * scaleHint
            }

            function decorateText(text, wordCompletionLength) {
                if (wordCompletionLength > 0) {
                    return text.slice(0, -wordCompletionLength) + '<u>' + text.slice(-wordCompletionLength) + '</u>';
                }

                return text;
            }
        }

        states: State {
            name: "current"
            when: selectionListItem.ListView.isCurrentItem
            PropertyChanges { target: selectionListLabel; color: "white" }
        }
    }

    selectionListBackground: Rectangle {
        color: "#060606"
    }

    //selectionListBottomOffset: 7
    //selectionListTopOffset: 2

    selectionListAdd: Transition {
        NumberAnimation { property: "y"; from: wordCandidateView.height }
        NumberAnimation { property: "opacity"; from: 0; to: 1 }
    }

    selectionListRemove: Transition {
        NumberAnimation { property: "y"; to: -wordCandidateView.height }
        NumberAnimation { property: "opacity"; to: 0 }
    }

    navigationHighlight: Rectangle {
        color: "transparent"
        border.color: "yellow"
        border.width: 5
    }

    //scrollBarKeyInnerOffset: 2
    //scrollBarKeyOuterOffset: 8

    suggestionsScrollKeyPanel: KeyPanel {
        id: suggestionsScrollKeyPanelDelegate
        BorderImage {
            id: scrollSuggestionKeyBackground

            anchors.fill: parent
            property bool highlight: false
            source: currentStyle.resourcePrefix + "images/9patch_flatbtn_center_" + (highlight ? "PRS" : "OFF") + ".png";


            border.left: 9; border.right: 9;
            border.top: 10; border.bottom: 10;

            Image {
                anchors.centerIn: parent
                source: suggestionsScrollKeyPanelDelegate.control.isLeftScrollKey? "images/ic_left.png" : "images/ic_right.png"
            }
        }

        states: [
            State {
                name: "pressed"
                when: control.pressed
                PropertyChanges { target: scrollSuggestionKeyBackground; highlight: true }
            },

            State {
                name: "disabled"
                when: !control.enabled
                PropertyChanges { target: scrollSuggestionKeyBackground; highlight: false; opacity: 0.6 }
            },

            State {
                name: "enabled"
                when: control.enabled
                PropertyChanges { target: scrollSuggestionKeyBackground; highlight: false; opacity: 1.0 }
            }
        ]
    }

    actionKeyPanel: KeyPanel {
        id: actionKeyPanelDelegate
        BorderImage {
            id: actionKeyBackground
            anchors.fill: parent

            property bool highlight: false

            border.left: 9; border.right: 9;
            border.top: 10; border.bottom: 10;

            source: currentStyle.resourcePrefix + "images/9patch_3Dbtn_Keyboard_" + (highlight ? "PRS" : "OFF") + ".png";

            Text {
                id: actionKeyText
                text: control.displayText
                color: "white"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.fill: parent
                anchors.leftMargin: keyContentMargin
                anchors.topMargin: control.smallTextVisible ? keyContentMargin * 1.2 : keyContentMargin
                anchors.rightMargin: keyContentMargin
                anchors.bottomMargin: control.smallTextVisible ? keyContentMargin * 0.8 : keyContentMargin
                font {
                    family: fontFamily
                    weight: Font.Light
                    pixelSize: 32 * scaleHint
                    capitalization: control.uppercased ? Font.AllUppercase : Font.MixedCase
                }
            }
        }

        states: [
            State {
                name: "pressed"
                when: control.pressed
                PropertyChanges { target: actionKeyBackground; highlight: true }
            },
            State {
                name: "disabled"
                when: !control.enabled
                PropertyChanges { target: actionKeyBackground; highlight: false }
            }
        ]
    }

    /*suggestionsBarActionKeyPanel: KeyPanel {
        id: suggestionBarActionKeyPanelDelegate

        Button {
            anchors.fill: parent
            text: suggestionBarActionKeyPanelDelegate.control.actionKeyText
            //color: suggestionBarActionKeyPanelDelegate.control.actionKeyColor
            enabled: suggestionBarActionKeyPanelDelegate.control.enabled
            onPressed: suggestionBarActionKeyPanelDelegate.control.active = true;
            onReleased: suggestionBarActionKeyPanelDelegate.control.active = false;
            onClicked: suggestionBarActionKeyPanelDelegate.control.clicked()
        }
    }*/

    traceInputKeyPanelDelegate: TraceInputKeyPanel {
        traceMargins: keyBackgroundMargin

        BorderImage {
            id: traceInputKeyPanelBackground
            source: currentStyle.resourcePrefix + "images/core_scribbleplate.png";

            border.left: 9; border.right: 9;
            border.top: 10; border.bottom: 10;
            anchors.fill: parent
            anchors.bottomMargin: keyBackgroundMargin * 2

            Label {
                text: "label_button_keyboard_help_text"
                color: "gray"
                anchors.centerIn: parent
                font.pixelSize: 32 * scaleHint
            }
        }

        Canvas {
            id: traceInputKeyGuideLines
            anchors.fill: traceInputKeyPanelBackground
            opacity: 0.1
            onPaint: {
                var ctx = getContext("2d")
                ctx.lineWidth = 1
                ctx.strokeStyle = Qt.rgba(0xFF, 0xFF, 0xFF)
                ctx.clearRect(0, 0, width, height)
                var i
                if (control.horizontalRulers) {
                    for (i = 0; i < control.horizontalRulers.length; i++) {
                        ctx.beginPath()
                        ctx.moveTo(0, control.horizontalRulers[i])
                        ctx.lineTo(width, control.horizontalRulers[i])
                        ctx.stroke()
                    }
                }
                if (control.verticalRulers) {
                    for (i = 0; i < control.verticalRulers.length; i++) {
                        ctx.beginPath()
                        ctx.moveTo(control.verticalRulers[i], 0)
                        ctx.lineTo(control.verticalRulers[i], height)
                        ctx.stroke()
                    }
                }
            }
        }
    }

    traceCanvasDelegate: TraceCanvas {
        id: traceCanvas

        onAvailableChanged: {
            if (!available)
                return
            var ctx = getContext("2d")
            if (parent.canvasType === "fullscreen") {
                ctx.lineWidth = 10
                ctx.strokeStyle = Qt.rgba(0, 0, 0)
            } else {
                ctx.lineWidth = 10 * scaleHint
                ctx.strokeStyle = Qt.rgba(0xFF, 0xFF, 0xFF)
            }
            ctx.lineCap = "round"
            ctx.fillStyle = ctx.strokeStyle
        }

        autoDestroyDelay: 800
        onTraceChanged: if (trace === null) opacity = 0

        Behavior on opacity { NumberAnimation { duration: 200 } }
    }

    popupListDelegate: SelectionListItem {
        id: popupListItem

        width: popupListLabel.width + popupListLabel.anchors.leftMargin * 2
        height: popupListLabel.height + popupListLabel.anchors.topMargin * 2

        property real cursorAnchor: popupListLabel.x + popupListLabel.width

        Text {
            id: popupListLabel
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: popupListLabel.height / 2
            anchors.topMargin: popupListLabel.height / 3
            text: decorateText(display, wordCompletionLength)
            color: "#5CAA15"

            font {
                family: fontFamily
                weight: Font.Normal
                pixelSize: Qt.inputMethod.cursorRectangle.height * 0.8
            }

            function decorateText(text, wordCompletionLength) {
                if (wordCompletionLength > 0) {
                    return text.slice(0, -wordCompletionLength) + '<u>' + text.slice(-wordCompletionLength) + '</u>'
                }

                return text
            }
        }

        states: State {
            name: "current"
            when: popupListItem.ListView.isCurrentItem
            PropertyChanges { target: popupListLabel; color: "black" }
        }
    }

    popupListBackground: Item {
        Rectangle {
            width: parent.width
            height: parent.height
            color: "white"
            border {
                width: 1
                color: "#929495"
            }
        }
    }

    popupListAdd: Transition {
        NumberAnimation { from: 0; to: 1.0; duration: 200 }
    }

    popupListRemove: Transition {
        NumberAnimation { to: 0; duration: 200 }
    }
}
