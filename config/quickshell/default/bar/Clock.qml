import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import "../config"
import "../services"

Rectangle {
    id: rectangle
    color: Colourscheme.surface
    implicitWidth: content.width
    implicitHeight: content.height
    radius: 10

    MarginWrapperManager {
        margin: 5
    }

    ColumnLayout {
        id: content

        ColumnLayout {
            spacing: 0
            Text {
                Layout.alignment: Qt.AlignHCenter
                font.pointSize: 16
                font.bold: true
                text: Time.day
                color: Colourscheme.text
            }
            Text {
                Layout.alignment: Qt.AlignHCenter
                font.pointSize: 12
                text: Time.month
                color: Colourscheme.subtle
            }
        }

        Rectangle {
            implicitHeight: 1
            implicitWidth: parent.implicitWidth
            color: Colourscheme.text
        }

        ColumnLayout {
            spacing: 0
            Layout.alignment: Qt.AlignHCenter
            Text {
                font.pointSize: 14
                font.bold: true
                text: Time.hours
                color: Colourscheme.subtle
            }
            Text {
                font.pointSize: 14
                font.bold: true
                text: Time.minutes
                color: Colourscheme.text
            }
        }
    }
}
