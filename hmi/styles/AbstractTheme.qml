/*
 * 64x64 ic_*
 * 48x48 _
 * 32x32 w_*
 */

import QtQuick 2.10
import utils 1.0

QtObject {
    property int screenWidth: 800
    property int screenHeight: 480

    property bool allowGlowing //allows all glow effects in the UI

    property int materialTheme //holds a material theme

    property color dimBackground //the color of dimmed background when a dialog is shown

    // Fonts
    property color primaryFontColor
    property color secondaryFontColor
    property color highlightingFontColor
    property color inverseFontColor

    property int defaultFontSize

    // Background colors, picture
    property color primaryBackgroundColor
    property color secondaryBackgroundColor
    property url background //path to the background image

    // ListItem
    property int listItemHeight
    property int listItemPrimaryFontSize
    property int listItemSecondaryFontSize

    // Icons
    property string iconsDirectory

    // Margin, spacing, padding
    property int spacingByDefault
    property int marginByDefault

    property int toolbarHeight
    property int toolbarFontSize

    property int buttonHeight

    //property color materialPrimaryColor //topbar;
    //property color materialAccentColor  //selected/clicked components;
    //property color materialBackgroundColor //background;
    //property color materialForegroundColor //fonts;
}
