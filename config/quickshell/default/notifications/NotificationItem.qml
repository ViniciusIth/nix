pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

Rectangle {
    id: root
    property var notification

    // Layout + appearance
    radius: 12
    color: Qt.rgba(0.12, 0.12, 0.12, 0.92)
    border.color: "#3a3a3a"
    implicitWidth: 360
    implicitHeight: Math.max(80, content.implicitHeight + 20)

    // Click-through dismiss
    MouseArea {
        anchors.fill: parent
        z: 100
        onClicked: root.notification.popup = false
    }

    RowLayout {
        id: content
        spacing: 14

        // --- Icon section ---
        Image {
            source: root.notification.appIcon
            visible: !!root.notification.appIcon && root.notification.appIcon !== ""
            // Layout.preferredWidth: visible ? 42 : 0
            // Layout.preferredHeight: 42
            // fillMode: Image.PreserveAspectFit
            smooth: true
        }

        // --- Main text block ---
        ColumnLayout {
            Layout.fillWidth: true
            spacing: 6

            // App name
            Text {
                text: root.notification.appName || root.notification.desktopEntry
                color: "#9ea0a4"
                font.pixelSize: 13
                elide: Text.ElideRight
                visible: text.length > 0
            }

            // Summary
            Text {
                text: root.notification.summary
                color: "white"
                font.pixelSize: 17
                font.bold: true
                wrapMode: Text.WordWrap
                Layout.fillWidth: true
            }

            // Body text
            Text {
                text: root.notification.body
                color: "#d0d0d0"
                wrapMode: Text.WordWrap
                font.pixelSize: 14
                Layout.fillWidth: true
                visible: text.length > 0
            }

            // --- Action buttons ---
            RowLayout {
                id: actionsRow
                spacing: 8
                visible: root.notification.actions && root.notification.actions.length > 0

                Repeater {
                    model: root.notification.actions || []

                    delegate: Rectangle {
                        radius: 6
                        height: 32
                        color: mouseArea.pressed ? "#505050" : mouseArea.containsMouse ? "#3d3d3d" : "#2c2c2c"
                        border.color: "#5a5a5a"
                        border.width: 1
                        Layout.preferredWidth: 120

                        Text {
                            anchors.centerIn: parent
                            text: modelData.label
                            color: "white"
                            font.pixelSize: 14
                        }

                        MouseArea {
                            id: mouseArea
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor

                            onClicked: {
                                modelData.trigger();
                                root.notification.popup = false;
                            }
                        }
                    }
                }
            }
        }
    }
}
