import Quickshell.Widgets
import QtQuick
import QtQuick.Effects
import "../config"

Item {
    id: root
    property alias source: image.source
    property alias fillMode: image.fillMode
    property real radius

    ClippingRectangle {
        height: parent.height
        width: parent.height
        radius: root.radius
        border.width: 2
        border.color: Colourscheme.highlightMed
        color: Colourscheme.base
        Image {
            id: image
            height: parent.height
            width: parent.height
        }
    }
}
