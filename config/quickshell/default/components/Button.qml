import QtQuick
import "../config"

MouseArea {
    id: root
    cursorShape: Qt.PointingHandCursor
    width: svg.width
    height: svg.height
    hoverEnabled: true

    property string source
    property real size

    SvgIcon {
        id: svg
        source: root.source
        size: root.size
        color: root.containsMouse ? Colourscheme.muted : Colourscheme.text
    }
}
