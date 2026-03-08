import Quickshell
import QtQuick
import Quickshell.Wayland
import QtQuick.Controls
import Quickshell.Widgets
import Quickshell.Hyprland
import "../../"

PanelWindow {
  readonly property var panelPosition: Config.settings.panel.position
  readonly property var panelSize: Config.settings.panel.size
  
  WlrLayershell.exclusionMode: WlrLayershell.Ignore
  implicitWidth: 320
  color: "transparent"

  anchors {
    top: true
    bottom: true
    right: panelPosition.match(/^(top|right|bottom)$/)
    left: panelPosition === "left"
  }
  
  margins {
    top: panelPosition === "top" ? panelSize + 10 : panelSize - 20
    bottom: panelPosition === "bottom" ? panelSize + 10 : panelSize - 20
  }

  
  Rectangle {
    id: root
    implicitWidth: parent.width
    implicitHeight: parent.height
    color: Config.settings.theme === "light" ? Colors.surface_variant : Colors.surface
    radius: 8
    border.width: 1
    border.color: Qt.alpha(Colors.outline, 0.1)
    
    ScrollView {
      id: notificationList
      anchors.fill: parent
      anchors.margins: 10
      ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
      ScrollBar.vertical.policy: ScrollBar.AsNeeded

      ListView {
        model: NotificationService.trackedNotifications   
        width: parent.width
        height: parent.width
        spacing: 8
        clip: true

        add: Transition {
          NumberAnimation { property: "opacity"; from: 0; to: 1.0; duration: 200 }
          NumberAnimation { property: "x"; from: 100; to: 0; duration: 150; easing.type: Easing.OutQuad }
        }
        
        remove: Transition {
            NumberAnimation { property: "opacity"; to: 0; duration: 200 }
            NumberAnimation { property: "x"; to: 500; duration: 150; easing.type: Easing.InQuad }
        }
        
        displaced: Transition {
          NumberAnimation { properties: "y"; duration: 100; easing.type: Easing.OutQuad }
        }

        delegate: NotificationCard {
          implicitWidth: notificationList.width
          appName: modelData.appName
          title: modelData.summary
          body: modelData.body
          image.source: modelData.image
          image.visible: modelData.image
          closeButton.onClicked: modelData.dismiss()
        }
      }

    }
  }
}
