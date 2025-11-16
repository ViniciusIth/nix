pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: root
    readonly property string time: {
        Qt.formatDateTime(clock.date, "yyyy-MM-dd\nHH:MM:ss");
    }

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }
}
