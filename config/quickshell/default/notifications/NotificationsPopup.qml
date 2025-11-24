import Quickshell
import QtQuick
import "../services" as Services

PanelWindow {
    anchors {
        top: true
        right: true
    }

    color: "transparent"
    width: popupColumn.implicitWidth
    height: popupColumn.implicitHeight

    Column {
        id: popupColumn
        spacing: 8
        anchors {
            top: parent.top
            right: parent.right
            left: parent.left
            topMargin: 8
            rightMargin: 8
        }

        Repeater {
            model: Services.Notification.popupNotifications

            delegate: NotificationItem {
                id: item
                notification: modelData

                SequentialAnimation on opacity {
                    NumberAnimation {
                        from: 0
                        to: 1
                        duration: 500
                        easing.type: Easing.OutCubic
                    }
                }
                opacity: modelData.popup ? 1 : 0
            }
        }
    }
}
