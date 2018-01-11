import QtQuick 2.9
import styles 1.0

Item {
    id: root

    /* For dubug: switching themes */
    Keys.onPressed: {
        if (event.key === Qt.Key_T) {
            if (StyleModel.currentThemePath === StyleModel.themeDark) {
                StyleModel.loadTheme(StyleModel.themeWhite)
            } else {
                StyleModel.loadTheme(StyleModel.themeDark)
            }
            event.accepted = true;
        }
    }
}
