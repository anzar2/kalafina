import Quickshell
import ".."
import "../utils/"
import "../components/notifications/"
import QtQuick
import Quickshell.Wayland
import QtQuick.Controls 
import Quickshell.Hyprland
import Quickshell.Services.Notifications


StyledPanelWindow {
  id: root
  readonly property var panelPosition: Config.settings.panel.position
  readonly property var panelSize: Config.settings.panel.size
  
  WlrLayershell.exclusionMode: WlrLayershell.Normal
  WlrLayershell.layer: Hyprland.focusedMonitor?.activeWorkspace?.hasFullscreen ? WlrLayershell.Overlay : WlrLayershell.Top
  
  implicitWidth: 350
  implicitHeight: NotificationService.server.globalNotificationsCount > 0  ? 190 : 45

  color: "transparent"

  anchors {
    top: panelPosition === "top" || NotificationService.properties.panelCollapsed
    bottom: panelPosition.match(/^(bottom|left|right)$/) || NotificationService.properties.panelCollapsed
    right: panelPosition.match(/^(top|right|bottom)$/)
    left: panelPosition === "left"
  }
  
  margins {
    top: 10
    bottom: 10
    right: 10
    left: 10
  }

  background.border.width: 1
  background.border.color: Theme.colors.surface_container_highest

  Component.onDestruction: {
    NotificationService.properties.panelCollapsed = false
  }
  
  Rectangle {
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right
    color: "transparent"
    radius: 4
    implicitHeight: expandButton.height
    anchors.margins: 10

    Row {
      anchors.left: parent.left
      anchors.leftMargin: 8
      spacing: 8

      Text {
        anchors.verticalCenter: parent.verticalCenter
        text: ""
        font.pixelSize: 16
        color: Theme.colors.on_surface
      }

      Text {
        anchors.verticalCenter: parent.verticalCenter
        text: NotificationService.server.globalNotificationsCount
        font.pixelSize: 13
        color: Theme.colors.on_surface
      }
    }
          
    Row {
      anchors.right: parent.right
      height: expandButton.height
      spacing: 4

      StyledSwitch {
        checked: !NotificationService.properties.dnd
        onClicked: NotificationService.properties.toggleDnd()
      }
      
      StyledButton {
        id: expandButton
        anchors.verticalCenter: parent.verticalCenter
        onClicked: {
          if (NotificationService.server.globalNotificationsCount > 0) {
            NotificationService.properties.collapsePanel()
          }
        }
        nerdIcon.text: pressed ?  "" : ""
      }
    }
  }

  
  ListView {
    id: notificationList
    model: NotificationService.server.trackedNotifications
    
    anchors.fill: parent
    anchors.margins: 10
    anchors.topMargin: 50
    spacing: 4
    clip: true
    verticalLayoutDirection: ListView.TopToBottom
    snapMode: ListView.SnapToItem
    
    highlightMoveDuration: 300

    onCountChanged: {
      currentIndex = count - 1
    }

    add: Transition {
      NumberAnimation { property: "x"; from: 100; to: 0; duration: 200; easing.type: Easing.OutQuad }
    }
    
    remove: Transition {
      NumberAnimation { property: "x"; to: 500; duration: 200; easing.type: Easing.InQuad }
    }
    
    displaced: Transition {
      NumberAnimation { properties: "y"; duration: 100; easing.type: Easing.OutQuad }
    }

    delegate: NotificationCard {
      id: notification
      required property Notification modelData
      implicitWidth: parent?.width
      appName: `${modelData?.appName ?? ""} - ${modelData.time}`
      title: modelData?.summary ?? ""
      body: modelData?.body ?? ""
      image.source: modelData?.image ?? ""
      image.visible: modelData?.image ?? false
      closeButton.onClicked: { 
        modelData?.dismiss()
        if (NotificationService.server.globalNotificationsCount < 1) {
          NotificationService.properties.showPanel = false
        }
      }

      TapHandler {
        onTapped: {
          Hyprland.dispatch(`focuswindow class:${notification.modelData?.desktopEntry.toLowerCase()}`)
          if (notification.modelData.actions.length > 0) {
              notification.modelData.actions[0].invoke() // I'm calling the first action always, i dont know how to handle this properly on UI so... 
          }
          notification.modelData?.dismiss()
          NotificationService.properties.showPanel = false
        }
      }
    }
  }
}
