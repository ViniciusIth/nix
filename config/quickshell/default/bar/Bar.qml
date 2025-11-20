import Quickshell
import QtQuick
import QtQuick.Layouts
import "../components"
import "../config"

Variants {
    model: Quickshell.screens

    PanelWindow {
        id: barWindow
        required property var modelData
        screen: modelData

        anchors {
            left: true
            top: true
            bottom: true
        }

        color: "transparent"
        exclusiveZone: barContent.contentWidth
        mask: Region {
            item: barContent
        }
        implicitWidth: barContent.width
        property real contentWidth: 52

        HuggingRectangle {
            id: barContent
            bottomEdge: true
            topEdge: true
            leftEdge: true
            contentHeight: parent.height
            contentWidth: barWindow.contentWidth
            backgroundColor: Colourscheme.base
            anchors {
                top: parent.top
                bottom: parent.bottom
                left: parent.left
            }

            ColumnLayout {
                anchors {
                    topMargin: 10
                    top: parent.top
                    horizontalCenter: parent.horizontalCenter
                }
                spacing: 10
            }

            ColumnLayout {
                anchors {
                    verticalCenter: parent.verticalCenter
                    horizontalCenter: parent.horizontalCenter
                }
                spacing: 10

                Clock {}
                PowerButton {}
            }

            ColumnLayout {
                anchors {
                    bottomMargin: 10
                    bottom: parent.bottom
                    horizontalCenter: parent.horizontalCenter
                }
                spacing: 10
            }
        }

        MouseArea {
            anchors {
                left: parent.left
                top: parent.top
                bottom: parent.bottom
            }

            implicitWidth: parent.implicitWidth
            hoverEnabled: true

            onEntered: {
                barWindow.visible = true;
            }

            onExited: {
                barWindow.visible = false;
            }
        }
    }

    // IpcHandler {
    //     target: "sidebar"
    //     function toggle() {
    //     }
    // }
}
