import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

import styles 1.0
import components 1.0

BDialog {
    id: root

    property alias text: dialogText.text

    BLabel {
        id: dialogText
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        text: root.text
    }
}
