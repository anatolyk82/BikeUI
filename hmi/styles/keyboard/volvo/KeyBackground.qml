import QtQuick 2.0

BorderImage {
    property bool highlight: false
    property bool alternateKeysVisible: false

    source: {
        if (highlight && !alternateKeysVisible) {
            return ""; //Charchter preview bubble shall handle 9patch_3Dbtn_Keyboard_PRS.png
        }
        else if (highlight && alternateKeysVisible) {
            return currentStyle.resourcePrefix + "images/9patch_3Dbtn_Keyboard_HPRS2.png";
        } else {
            return currentStyle.resourcePrefix + "images/9patch_3Dbtn_Keyboard_OFF.png";
        }
    }

    border.left: 9; border.right: 9;
    border.top: 10; border.bottom: 10;
    anchors.fill: parent
}
