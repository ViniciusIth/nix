import QtQuick
import "../../components"

MouseArea {
    id: mouseArea
    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor
    implicitWidth: content.implicitWidth
    implicitHeight: content.implicitHeight
    property string icon
    property color color
    property color colorHover: mouseArea.color
    property color background: "transparent"
    property color backgroundHover: "transparent"
    property real iconSize: 24
    anchors.horizontalCenter: parent.horizontalCenter

    Rectangle {
        id: content
        implicitWidth: mouseArea.iconSize + 6
        implicitHeight: mouseArea.iconSize + 6
        color: mouseArea.containsMouse ? mouseArea.backgroundHover : mouseArea.background
        radius: 10

        Behavior on color {
            ColorAnimation {
                duration: 200
            }
        }

        SvgIcon {
            id: svgIcon
            Behavior on color {
                ColorAnimation {
                    duration: 200
                }
            }
            size: mouseArea.iconSize
            anchors.centerIn: parent
            source: mouseArea.icon
            color: mouseArea.containsMouse ? mouseArea.colorHover : mouseArea.color
        }
    }
}
