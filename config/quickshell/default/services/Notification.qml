pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Services.Notifications

Singleton {
    id: root

    property ListModel notifications: ListModel {}
    property ListModel popupNotifications: ListModel {}

    NotificationServer {
        id: server
        actionsSupported: true
        keepOnReload: false

        onNotification: notification => {
            console.log("incoming:", notification.summary, notification.body);

            notification.tracked = true;
            notification.popup = true;

            root.addOrUpdateNotification(notification);

            root.scheduleExpiration(notification);
        }
    }

    Component {
        id: expireTimer
        Timer {
            required property Notification notification
            running: true
            repeat: false

            onTriggered: {
                console.log("expiring", notification.summary);
                notification.popup = false;
                root.updatePopupNotification(notification);
                Qt.callLater(() => destroy());
            }
        }
    }

    function scheduleExpiration(notification: Notification) {
        const timeout = notification.expireTimeout > 0 ? notification.expireTimeout : 5000;
        expireTimer.createObject(root, {
            notification: notification,
            interval: timeout
        });
    }

    function addOrUpdateNotification(n) {
        let idx = findById(notifications, n.id);
        if (idx >= 0) {
            notifications.set(idx, {
                n: n
            });
        } else {
            notifications.append({
                n: n
            });
        }

        if (n.popup) {
            let pidx = findById(popupNotifications, n.id);
            if (pidx < 0)
                popupNotifications.append({
                    n: n
                });
            else
                popupNotifications.set(pidx, {
                    n: n
                });
        }
    }

    function updatePopupNotification(n) {
        let idx = findById(popupNotifications, n.id);
        if (idx >= 0 && !n.popup)
            popupNotifications.remove(idx);
    }

    function findById(model, id) {
        for (let i = 0; i < model.count; i++) {
            if (model.get(i).n.id === id)
                return i;
        }
        return -1;
    }
}
