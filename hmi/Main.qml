import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.2
import Qt.labs.settings 1.0

import utils 1.0
import components 1.0
import common 1.0
import styles 1.0

import power 1.0
import hmi_utils 1.0
import styles 1.0

import system.settings 1.0

import QtGraphicalEffects 1.0

ApplicationWindow {
    id: window

    visible: true
    width: StyleModel.screenWidth
    height: StyleModel.screenHeight

    title: SystemModel.currentApplicationTitle

    header: MainToolBar {
        id: toolBar
        onTopBarClicked: drawer.open()
    }

    MainDrawer {
        id: drawer
        onPoweroff: {
            drawer.close()
            msgPoweroff.open()
        }
        onReboot: {
            drawer.close()
            msgReboot.open()
        }
        onStopwatch: {
            drawer.close()
            stopwatch.open()
        }
        onSettings: {
            appPage.runApplication(SettingsModel.applicationId, SettingsModel.settingsTitle, Qt.resolvedUrl("system/settings/SettingsMainView.qml"))
            mainSwipeView.currentIndex = 1
            drawer.close()
        }
    }

    //------------------------------
    ApplicationsModel {
        id: appsModel
        appsDirectiry: SystemModel.appsDirectory
    }

    SwipeView {
        id: mainSwipeView
        orientation: Qt.Vertical
        anchors.fill: parent
        interactive: SystemModel.verticalMainSwipeEnabled

        Carousel {
            id: carouselMenu
            model: appsModel
            delegate: MainMenuItem {
                count: appsModel.rowCount()
                currentIndex: index
                isCurrentIndex: ListView.view.currentIndex === index
                icon: model.icon
                name: model.name
                width: carouselMenu.delegateItemWidth
                height: ListView.view.height
                onItemClicked: {
                    ListView.view.currentIndex = index
                    appPage.runApplicationModel(model)
                    mainSwipeView.currentIndex = 1
                }
                onItemMoved: appsModel.moveElement(index, newIndex)
                onRequestToBeCurrentItem: ListView.view.currentIndex = requestingIndex
            }
        }

        ApplicationView {
            id: appPage
        }

        onCurrentIndexChanged: {
            SystemModel.activeScreenNumber = currentIndex
            SystemModel.currentApplicationTitle = appPage.currentAppTitle
        }
    }

    //------------------------

    MessageDialog {
        id: msgReboot
        title: qsTr("Reboot the system")
        text: qsTr("Do you want to reboot the system ?")
        onOkClicked: Power.reboot()
        onCancelClicked: msgReboot.close()
    }
    MessageDialog {
        id: msgPoweroff
        title: qsTr("Shutdown the system")
        text: qsTr("Do you want to shutdown the system ?")
        onOkClicked: Power.poweroff()
        onCancelClicked: msgPoweroff.close()
    }

    //-------------------- Theme
    //background: StyleModel.background
    Material.theme: StyleModel.materialTheme
    background: Image {
        source: StyleModel.theme.background
    }
    //Material.primary: StyleModel.primaryColor
    //Material.accent: StyleModel.accentColor
    //Material.foreground: StyleModel.foregroundColor
    Material.background: StyleModel.primaryBackgroundColor

    overlay.modal: Rectangle {
        color: StyleModel.dimBackground
    }
    overlay.modeless: Rectangle {
        color: StyleModel.dimBackground
    }

    //-------------------------------------

    KeysDebug {
        focus: true
    }

    GlobalPopups {}

    Component.onCompleted: {
        carouselMenu.currentIndex = 1
        StyleModel.loadTheme(StyleModel.themeDark)
    }
}
