import Quickshell
import Quickshell.Wayland
import Quickshell.Widgets
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

PanelWindow {
    id: launcher
    property bool open: false

    anchors {
        top: true
    }

    visible: open
    exclusiveZone: 0
    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive

    Shortcut {
        sequence: StandardKey.Cancel
        onActivated: {
            launcher.open = false;
        }
    }

    IpcHandler {
        target: "launcher"
        function toggle() {
            launcher.open = !launcher.open;
        }
    }
}
