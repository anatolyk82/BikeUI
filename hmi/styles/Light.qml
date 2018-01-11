import QtQuick 2.9
import QtQuick.Controls.Material 2.2
import utils 1.0

AbstractTheme {
    materialTheme: Material.Light

    allowGlowing: false
    background: Utils.background("bg_light")

    primaryFontColor: "black"
    secondaryFontColor: "grey"
    highlightingFontColor: "#ffff00" //FIXME
    inverseFontColor: "white"

    dimBackground: "#8f28282a"

    defaultFontSize: 24

    primaryBackgroundColor: "white"
    secondaryBackgroundColor: "lightgrey"

    listItemHeight: 70
    listItemPrimaryFontSize: 24
    listItemSecondaryFontSize: 16

    iconsDirectory: "Light"

    toolbarHeight: 48
    toolbarFontSize: 20

    buttonHeight: 80
}

