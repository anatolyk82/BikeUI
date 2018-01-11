import QtQuick 2.10
import QtQuick.Controls 2.3
import Qt.labs.settings 1.0

import components 1.0
import utils 1.0
import styles 1.0


import "."
import "./widgets"

Item {
    id: root

    signal callOptions(string widgetType, int widgetRow, int widgetColumn, bool hasOptions)

    property alias name: widgetPageSettings.category

    /* Each widget page has its own settings to remeber all widgets on it */
    readonly property Settings widgetPageSettings: Settings {
        id: widgetPageSettings
        property string widgetSource11: RideModel.widgetSmallFile
        property string widgetSource12: RideModel.widgetSmallFile
        property string widgetSource13: RideModel.widgetSmallFile
        property string widgetSource21: RideModel.widgetSmallFile
        property string widgetSource22: RideModel.widgetSmallFile
        property string widgetSource23: RideModel.widgetSmallFile
    }

    property bool allAvailableWidgetsDisplayed: false

    /* the menu in the dialog */
    readonly property ListModel dialogMenuModelBig: ListModel {
        ListElement { type: "all_big_widgets" }
        ListElement { type: "widget_settings" }
        ListElement { type: "make_two_widget" }
        ListElement { type: "make_three_widget" }
    }

    readonly property ListModel dialogMenuModelMiddle: ListModel {
        ListElement { type: "all_middle_widgets" }
        ListElement { type: "widget_settings" }
        ListElement { type: "make_one_widget" }
        ListElement { type: "make_three_widget" }
    }

    readonly property ListModel dialogMenuModelSmall: ListModel {
        ListElement { type: "all_small_widgets" }
        ListElement { type: "widget_settings" }
        ListElement { type: "make_one_widget" }
        ListElement { type: "make_two_widget" }
    }


    /* Container of all widgets on the page */
    Row {
        anchors.fill: parent
        spacing: 0
        Column {
            spacing: 0
            width: parent.width/2
            WidgetContainer {
                id: widget11
                source: widgetPageSettings.widgetSource11
                containerRow: 1
                containerColumn: 1
                onWidgetReady: {
                    item.optionsActivated.connect(root.callOptions)
                }
            }
            WidgetContainer {
                id: widget12
                source: widgetPageSettings.widgetSource12
                containerRow: 2
                containerColumn: 1
                onWidgetReady: {
                    item.optionsActivated.connect(root.callOptions)
                }
            }
            WidgetContainer {
                id: widget13
                source: widgetPageSettings.widgetSource13
                containerRow: 3
                containerColumn: 1
                onWidgetReady: {
                    item.optionsActivated.connect(root.callOptions)
                }
            }
        }
        Column {
            spacing: 0
            width: parent.width/2
            WidgetContainer {
                id: widget21
                source: widgetPageSettings.widgetSource21
                containerRow: 1
                containerColumn: 2
                onWidgetReady: {
                    item.optionsActivated.connect(root.callOptions)
                }
            }
            WidgetContainer {
                id: widget22
                source: widgetPageSettings.widgetSource22
                containerRow: 2
                containerColumn: 2
                onWidgetReady: {
                    item.optionsActivated.connect(root.callOptions)
                }
            }
            WidgetContainer {
                id: widget23
                source: widgetPageSettings.widgetSource23
                containerRow: 3
                containerColumn: 2
                onWidgetReady: {
                    item.optionsActivated.connect(root.callOptions)
                }
            }
        }
    }

    Connections {
        target: root
        onCallOptions: {
            dialogPageOptions.callingWidgetType = widgetType
            dialogPageOptions.callingWidgetRow = widgetRow
            dialogPageOptions.callingWidgetColumn = widgetColumn
            dialogPageOptions.callingWidgetHasOptions = hasOptions
            dialogPageOptions.open()
        }
    }

    //----------------------------------

    Component {
        id: listItemCreateWidgets
        ListItem {
            width: parent.width
            primaryText: itemText(model.type)

            visible: {
                if (model.type === "widget_settings") {
                    if (dialogPageOptions.callingWidgetHasOptions) {
                        return true
                    } else {
                        return false
                    }
                } else {
                    return true
                }
            }

            height: visible ? StyleModel.listItemHeight : 0

            iconSource: {
                if ((model.type === "all_big_widgets")||(model.type === "all_middle_widgets")||(model.type === "all_small_widgets")) {
                    Utils.icon("ic_settings")
                } else if (model.type === "widget_settings") {
                    Utils.icon("ic_settings")
                } else if (model.type === "make_one_widget") {
                    Utils.icon("cells1")
                } else if (model.type === "make_two_widget") {
                    Utils.icon("cells2")
                } else if (model.type === "make_three_widget") {
                    Utils.icon("cells3")
                }
            }

            onClicked: {
                if ((model.type === "all_big_widgets")||(model.type === "all_middle_widgets")||(model.type === "all_small_widgets")) {
                    allAvailableWidgetsDisplayed = true
                } else if (model.type === "widget_settings") {
                    dialogPageOptions.close()
                    var d = null
                    var c = dialogPageOptions.callingWidgetColumn
                    var r = dialogPageOptions.callingWidgetRow
                    if (c === 1) {
                        if (r === 1) {
                            d = widget11.item
                        } else if (r === 2) {
                            d = widget12.item
                        } else if (r === 3) {
                            d = widget13.item
                        }
                    } else if (c === 2) {
                        if (r === 1) {
                            d = widget21.item
                        } else if (r === 2) {
                            d = widget22.item
                        } else if (r === 3) {
                            d = widget23.item
                        }
                    }
                    if (d.widgetSettings !== null) {
                        dialogWidgetSettings.sourceComponent = d.widgetSettings
                        dialogWidgetSettings.width = d.widgetSettingsWidth
                        dialogWidgetSettings.height = d.widgetSettingsHeight
                        dialogWidgetSettings.title = d.widgetSettingsDialogTitle
                        dialogWidgetSettings.open()
                    }
                } else if (model.type === "make_one_widget") {
                    createOneWidgets(dialogPageOptions.callingWidgetColumn)
                } else if (model.type === "make_two_widget") {
                    createTwoWidgets(dialogPageOptions.callingWidgetColumn)
                } else if (model.type === "make_three_widget") {
                    createThreeWidgets(dialogPageOptions.callingWidgetColumn)
                }
            }
        }
    }

    Component {
        id: listItemSetWidgets
        ListItem {
            width: parent.width
            primaryText: model.name
            secondaryText: model.description
            iconSource: Utils.icon(model.icon)
            onClicked: {
                var replacingFile = model.file

                //set an empty widget if the chosen item doesn't have a file
                if (replacingFile === "") {
                    if (dialogPageOptions.callingWidgetType === RideModel.widgetBigType) {
                        replacingFile = RideModel.widgetBigFile
                    } else if (dialogPageOptions.callingWidgetType === RideModel.widgetMediumType) {
                        replacingFile = RideModel.widgetMediumFile
                    } else if (dialogPageOptions.callingWidgetType === RideModel.widgetSmallType) {
                        replacingFile = RideModel.widgetSmallFile
                    }
                }

                setWidgetToLoader(dialogPageOptions.callingWidgetRow, dialogPageOptions.callingWidgetColumn, replacingFile)

                dialogPageOptions.close()
            }
        }
    }

    BDialog {
        id: dialogPageOptions

        property string callingWidgetType: ""
        property int callingWidgetColumn: 0
        property int callingWidgetRow: 0
        property bool callingWidgetHasOptions: false //TODO ?

        x: (root.width - width)/2
        y: (root.height - height)/2

        width: root.width*0.85
        height: root.height*0.95

        title: qsTr("Widget options")
        dialogButtons: 0

        ListView {
            clip: true

            ScrollIndicator.vertical: ScrollIndicator { }

            model: {
                if (allAvailableWidgetsDisplayed) {
                    if (dialogPageOptions.callingWidgetType == RideModel.widgetBigType) {
                        return RideModel.modelBigWidgets
                    } else if (dialogPageOptions.callingWidgetType == RideModel.widgetMediumType) {
                        return RideModel.modelMediumWidgets
                    } else if (dialogPageOptions.callingWidgetType == RideModel.widgetSmallType) {
                        return RideModel.modelSmallWidgets
                    }
                } else {
                    return getListModel(dialogPageOptions.callingWidgetColumn)
                }
            }
            delegate: allAvailableWidgetsDisplayed ? listItemSetWidgets : listItemCreateWidgets
        }

        onVisibleChanged: {
            if (!visible) {
                allAvailableWidgetsDisplayed = false
            }
        }
    }


    /*
     * It returns a model of all available widgets
     * in a specified column numColumn
     */
    function getListModel(numColumn) {
        if (numColumn === 1) {
            if (widget11.containerWidgetType === RideModel.widgetSmallType) {
                return dialogMenuModelSmall
            } else if(widget11.containerWidgetType === RideModel.widgetMediumType) {
                return dialogMenuModelMiddle
            } else {
                return dialogMenuModelBig
            }
        } else if (numColumn === 2) {
            if (widget21.containerWidgetType === RideModel.widgetSmallType) {
                return dialogMenuModelSmall
            } else if(widget21.containerWidgetType === RideModel.widgetMediumType) {
                return dialogMenuModelMiddle
            } else {
                return dialogMenuModelBig
            }
        }
    }

    /*
     * This returns a translation for each item in the dialog
     */
    function itemText(text) {
        if ((text === "all_big_widgets")||(text === "all_middle_widgets")||(text === "all_small_widgets")) {
            return qsTr("Choose a widget")
        } else if (text === "widget_settings") {
            return qsTr("Widget settings")
        } else if (text === "make_one_widget") {
            return qsTr("One big tile")
        } else if (text === "make_two_widget") {
            return qsTr("Two medium tiles")
        } else if (text === "make_three_widget") {
            return qsTr("Three small tiles")
        }
    }

    /*
     * This creates the big widget in a model in the dialog
     */
    function createOneWidgets(numColumn) {
        if (numColumn === 1) {
            widgetPageSettings.widgetSource11 = RideModel.widgetBigFile
            widgetPageSettings.widgetSource12 = ""
            widgetPageSettings.widgetSource13 = ""
        } else if (numColumn === 2) {
            widgetPageSettings.widgetSource21 = RideModel.widgetBigFile
            widgetPageSettings.widgetSource22 = ""
            widgetPageSettings.widgetSource23 = ""
        }
        dialogPageOptions.close()
    }

    /*
     * This creates two medium widgets in a model in the dialog
     */
    function createTwoWidgets(numColumn) {
        if (numColumn === 1) {
            widgetPageSettings.widgetSource11 = RideModel.widgetMediumFile
            widgetPageSettings.widgetSource12 = RideModel.widgetMediumFile
            widgetPageSettings.widgetSource13 = ""
        } else if (numColumn === 2) {
            widgetPageSettings.widgetSource21 = RideModel.widgetMediumFile
            widgetPageSettings.widgetSource22 = RideModel.widgetMediumFile
            widgetPageSettings.widgetSource23 = ""
        }
        dialogPageOptions.close()
    }

    /*
     * This creates three small widgets in a model in the dialog
     */
    function createThreeWidgets(numColumn) {
        if (numColumn === 1) {
            widgetPageSettings.widgetSource11 = RideModel.widgetSmallFile
            widgetPageSettings.widgetSource12 = RideModel.widgetSmallFile
            widgetPageSettings.widgetSource13 = RideModel.widgetSmallFile
        } else if (numColumn === 2) {
            widgetPageSettings.widgetSource21 = RideModel.widgetSmallFile
            widgetPageSettings.widgetSource22 = RideModel.widgetSmallFile
            widgetPageSettings.widgetSource23 = RideModel.widgetSmallFile
        }
        dialogPageOptions.close()
    }


    /*
     * This sets a certain file as a source to specified loader in the row r and column c
     */
    function setWidgetToLoader(r,c,file) {
        if (c === 1) {
            if (r === 1) {
                widgetPageSettings.widgetSource11 = file
            } else if (r === 2) {
                widgetPageSettings.widgetSource12 = file
            } else if (r === 3) {
                widgetPageSettings.widgetSource13 = file
            }
        } else if (c === 2) {
            if (r === 1) {
                widgetPageSettings.widgetSource21 = file
            } else if (r === 2) {
                widgetPageSettings.widgetSource22 = file
            } else if (r === 3) {
                widgetPageSettings.widgetSource23 = file
            }
        }
    }

    //--------------------

    BDialog {
        id: dialogWidgetSettings
        dialogButtons: 0
        property alias sourceComponent: loader.sourceComponent
        Loader {
            id: loader
            anchors.fill: parent
            active: dialogWidgetSettings.visible
            asynchronous: true
            BusyIndicator {
                anchors.centerIn: parent
                visible: loader.status == Loader.Loading
            }
        }
    }
}
