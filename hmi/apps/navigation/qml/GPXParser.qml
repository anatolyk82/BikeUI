import QtQuick 2.7
import QtQuick.XmlListModel 2.0

QtObject {
    id: root

    property string gpxFile: ""

    property XmlListModel gpxModel: XmlListModel {
        source: root.gpxFile
        query: "/gpx/trk/trkseg"

        XmlRole { name: "latitude"; query: "@lat/string()" }
        XmlRole { name: "longitude"; query: "@lon/string()" }
        XmlRole { name: "altitude"; query: "ele/string()" }
    }
}
