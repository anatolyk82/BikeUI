import QtQuick 2.8
import Qt.labs.settings 1.0
import QtQuick.Controls 2.1

import ".."

//TODO: replace it by an Item and cover with RippleEffect when I port it from Qt
MenuItem {
    id: root

    property string name: "widget_name"

    /* type of the widget */
    property string widgetType: ""

    /* widget location */
    property int widgetRow: 0
    property int widgetColumn: 0

    /* parameters which a widget uses for the dialog with its options */
    property var widgetSettings: null
    property int widgetSettingsWidth: 550
    property int widgetSettingsHeight: 400
    property int widgetSettingsDialogButtons: Dialog.Ok | Dialog.Cancel
    property string widgetSettingsDialogTitle: qsTr("Settings")

    /* it's emmited when the user calls options by pressing and holding the widget */
    signal optionsActivated(string widgetType, int widgetRow, int widgetColumn, bool hasOptions)

    property alias plusVisible: addSymbol.visible

    Label {
        id: addSymbol
        anchors.centerIn: parent
        color: "lightgrey"
        font.pixelSize: 50
        text: "+"
        visible: false
    }

    onPressAndHold: root.optionsActivated(widgetType, widgetRow, widgetColumn, (widgetSettings !== null))
}
