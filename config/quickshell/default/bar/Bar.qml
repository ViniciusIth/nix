import Quickshell

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData
            screen: modelData

            anchors {
                top: true
                left: true
                bottom: true
            }

            ClockWidget {
                topPadding: 15
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }
}
