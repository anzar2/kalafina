import Quickshell
import QtQuick
import "../../"
import "../../utils/"

StyledButton {
  nerdIcon.text: {
    if (NotificationService.properties.showPanel) { 
 
      return NotificationService.properties.dnd ? "󰒲" : "󰍨" 
    }
    return NotificationService.properties.dnd ? "󰒲" : "󱜽"
  }
  onClicked: NotificationService.properties.togglePanel()
  backgroundRect.color: NotificationService.properties.showPanel || hovered ? Theme.colors.surface_container_high : "transparent"

  Rectangle {
    anchors.right: parent.right
    anchors.top: parent.top
    anchors.topMargin: 5
    anchors.rightMargin: 4
    color: "#ff758f"
    z: 1
    width: 8
    height: 8
    radius: 10
    visible: NotificationService.server.globalNotificationsCount > 0
  }
}
