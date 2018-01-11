import QtQuick 2.9

QtObject {
    id: root

    property string appId: ""             // Unique application id ( like org.bike.something )

    property bool enabled: false          // Enable/Disable the app

    property string appName: ""           // The application name
    property string appDescription: ""    // The appkication description
    property string appIcon: ""           // The application icon to display in the main menu
    property string mainFile: ""          // The main file to run the app
}
