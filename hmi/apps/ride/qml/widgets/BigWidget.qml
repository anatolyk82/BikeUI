import QtQuick 2.8
import QtQuick.Controls 2.1

import ".."

BaseWidget {
    id: root

    clip: true
    plusVisible: true
    widgetType: RideModel.widgetBigType

    width: RideModel.widgetWidth
    height: RideModel.widgetBig
}
