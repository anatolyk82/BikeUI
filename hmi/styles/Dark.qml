import QtQuick 2.9
import QtQuick.Controls.Material 2.2
import utils 1.0

AbstractTheme {
    materialTheme: Material.Dark

    allowGlowing: false

    background: Utils.background("bg_blue")

    primaryFontColor: "white"
    secondaryFontColor: "grey"
    highlightingFontColor: "#00aaff"
    inverseFontColor: "black"

    dimBackground: "#8f28282a"

    defaultFontSize: 24

    primaryBackgroundColor: "#01008a"
    secondaryBackgroundColor: "#000106"

    listItemHeight: 70
    listItemPrimaryFontSize: 24
    listItemSecondaryFontSize: 16

    iconsDirectory: "Dark"

    toolbarHeight: 48
    toolbarFontSize: 22

    buttonHeight: 80
}
