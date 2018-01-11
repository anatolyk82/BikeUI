import QtQuick 2.0

BorderImage {
    property bool highlight: false

    source: {
        if (highlight) {
            return currentStyle.resourcePrefix + "images/9patch_3Dbtn_Keyboard_PRS.png";
        } else {
            return currentStyle.resourcePrefix + "images/9patch_3Dbtn_Keyboard_SOFF.png";
        }
    }

    border.left: 9; border.right: 9;
    border.top: 10; border.bottom: 10;
    anchors.fill: parent
    //anchors.leftMargin: -4
    //anchors.rightMargin: -4
    //anchors.bottomMargin: -4
    //anchors.topMargin: -4
}
