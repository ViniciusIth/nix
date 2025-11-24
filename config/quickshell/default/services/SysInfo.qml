pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    property string osName
    property string osPrettyName
    property string osId
    property string osVersion
    property string osVersionId
    property string osVersionName
    property string osLogoName
    property string osLogo
    property int uptimeSeconds
    readonly property string user: Quickshell.env("USER")
    readonly property string wm: Quickshell.env("XDG_CURRENT_DESKTOP") || Quickshell.env("XDG_SESSION_DESKTOP")

    FileView {
        id: osRelease

        path: "/etc/os-release"
        onLoaded: {
            const lines = text().split("\n");

            const fd = key => lines.find(l => l.startsWith(`${key}=`))?.split("=")[1].replace(/"/g, "") ?? "";

            root.osName = fd("NAME");
            root.osPrettyName = fd("PRETTY_NAME");
            root.osId = fd("ID");
            root.osVersion = fd("VERSION");
            root.osVersionId = fd("VERSION_CODENAME");
            root.osVersionName = fd("VERSION_ID");

            const logo = Quickshell.iconPath(fd("LOGO"), true);
            if (logo) {
                root.osLogo = logo;
                root.osLogoName = fd("LOGO");
            }
        }
    }

    FileView {
        id: fileUptime

        path: "/proc/uptime"
        onLoaded: {
            const up = parseInt(text().split(" ")[0] ?? 0);
            root.uptimeSeconds = up;
        }
    }

    Timer {
        running: true
        repeat: true
        interval: 15000
        onTriggered: fileUptime.reload()
    }
}
