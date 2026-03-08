import Quickshell
import QtQuick
import Quickshell.Wayland
import Quickshell.Services.Notifications
import QtQuick.Controls
import "../.."

PanelWindow {
  id: root
  implicitWidth: 340
  anchors.right: true
  anchors.bottom: true
  color: "black"
  implicitHeight: notificationList.height
  
  margins {
    top: 10
    right: 10
    left: 10
    bottom: 10
  }

  WlrLayershell.exclusionMode: WlrLayershell.Ignore

  ListView {
    id: notificationList
    model: NotificationService.notifications
    height: 100
    spacing: 8
    verticalLayoutDirection: ListView.BottomToTop

    delegate: NotificationCard {
      required property Notification modelData
      title: modelData.summary
      body: modelData.body
      appName: modelData.appName
      image.source: modelData.image
      closeButton.onClicked: {
        modelData.dismiss()
        NotificationService.notifications.splice(NotificationService.notifications.indexOf(modelData), 1)
      }
    }
  }
}

