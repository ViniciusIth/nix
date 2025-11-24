import Quickshell
import "./bar" as Bar
import "./launcher" as Launcher
import "./notifications" as Notifications
import QtQuick

Scope {
    Bar.Bar {}
    Launcher.AppLauncher {}

    Notifications.NotificationsPopup {}
}
