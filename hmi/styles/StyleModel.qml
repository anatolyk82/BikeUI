pragma Singleton
import QtQuick 2.9

QtObject {
    id: root

    property Component themeComponent: null
    property QtObject theme: null

    property Component themeComponentNext: null
    property QtObject themeNext: null

    property Component themeComponentPrev: null
    property QtObject themePrev: null

    readonly property string themeDark: Qt.resolvedUrl("./Dark.qml")
    readonly property string themeWhite: Qt.resolvedUrl("./Light.qml")
    property string currentThemePath: ""

    // Theme data
    readonly property int screenWidth: theme.screenWidth
    readonly property int screenHeight: theme.screenHeight

    readonly property int availableScreenHeight: screenHeight - toolbarHeight
    readonly property int availableScreenWidth: screenWidth

    readonly property bool allowGlowing: theme.allowGlowing
    readonly property color dimBackground: theme.dimBackground

    readonly property int materialTheme: theme.materialTheme
    readonly property color primaryFontColor: theme.primaryFontColor
    readonly property color secondaryFontColor: theme.secondaryFontColor
    readonly property color inverseFontColor: theme.inverseFontColor
    readonly property color primaryBackgroundColor: theme.primaryBackgroundColor
    readonly property Image background: Image {
        source: theme.background
    }

    readonly property int defaultFontSize: theme.defaultFontSize

    readonly property int listItemHeight: theme.listItemHeight
    readonly property int listItemPrimaryFontSize: theme.listItemPrimaryFontSize
    readonly property int listItemSecondaryFontSize: theme.listItemSecondaryFontSize

    readonly property string iconsDirectory: theme.iconsDirectory

    readonly property int toolbarHeight: theme.toolbarHeight
    readonly property int toolbarFontSize: theme.toolbarFontSize

    readonly property int buttonHeight: theme.buttonHeight
    // ---------------------

    function loadTheme(_theme) {
        console.log("Loading theme: "+_theme)
        themeComponentNext = Qt.createComponent(_theme)
        if (themeComponentNext.status === Component.Ready) {
            finishThemeCreation(_theme)
        } else {
            themeComponentNext.statusChanged.connect(finishThemeCreation);
        }
    }

    function finishThemeCreation(_theme) {
        if (themeComponentNext.status === Component.Ready) {
            themeNext = themeComponentNext.createObject(root.parent, {});
            if (themeNext === null) {
                console.log("Error creating object");
            } else {
                currentThemePath = _theme

                themeComponentPrev = themeComponent
                themePrev = theme

                themeComponent = themeComponentNext
                theme = themeNext

                if (themeComponentPrev !== null) {
                    themePrev.destroy()
                    themePrev = null
                    themeComponentPrev.destroy()
                    themeComponentPrev = null
                }

                themeComponentNext = null
                themeNext = null
            }
        } else if (themeComponentNext.status === Component.Error) {
            console.log("Error loading component:", themeComponentNext.errorString());
        }
    }
}
