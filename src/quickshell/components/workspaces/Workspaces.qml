pragma ComponentBehavior: Bound
import Quickshell
import QtQuick
import Quickshell.Widgets
import Quickshell.Hyprland
import "../.."
import "../utils/"

Rectangle {
  id: root
  property bool panelVertical: Config.settings.panel.position === "right" || Config.settings.panel.position === "left"
  implicitWidth: workspacesFlow.width
  implicitHeight: workspacesFlow.height
  color: Qt.alpha(Colors.primary, 0.1)
  radius: 99

  MouseArea {
    anchors.fill: parent
    onWheel: (event) => {
      if (event.angleDelta.y > 0) {
        Hyprland.dispatch("workspace -1")
      } else Hyprland.dispatch("workspace +1")
    }
  }


  Flow {
    id: workspacesFlow
    anchors.centerIn: parent
    leftPadding: !root.panelVertical ? 12 : 8
    rightPadding: !root.panelVertical ? 12 : 8
    topPadding: root.panelVertical ? 12 : 8 
    bottomPadding: root.panelVertical ? 12 : 8
    spacing: 8
    flow: root.panelVertical ?  Flow.TopToBottom : Flow.LeftToRight
 
    Repeater {
      model: Hyprland.workspaces.values.filter(ws => ws.id > 0)
      delegate: Item {
        id: workspace
        required property HyprlandWorkspace modelData
        property bool isFocused: modelData.id === Hyprland.focusedWorkspace.id
        property int toplevelsCount: modelData.toplevels.values.length
        implicitWidth: root.panelVertical ? 12 : indicator.width
        implicitHeight: root.panelVertical ? indicator.height : 12

        Rectangle {
          id: indicator
          implicitWidth: toplevelsFlow.width
          implicitHeight: toplevelsFlow.height
          
          radius: root.radius
          color: workspace.isFocused || hoverHandler.hovered ? Qt.alpha(Colors.on_surface, 0.3) : Qt.alpha(Colors.primary, 0.1)
          anchors.centerIn: parent
          
          Behavior on implicitHeight { NumberAnimation { duration: 100; easing.type: Easing.OutQuad } }
          Behavior on implicitWidth { NumberAnimation { duration: 100; easing.type: Easing.OutQuad } }
          Behavior on color { ColorAnimation { duration: 100; easing.type: Easing.OutQuad } }
          TapHandler { onSingleTapped: workspace.modelData.activate() }
          HoverHandler { id: hoverHandler; cursorShape: Qt.PointingHandCursor }
                    
          Flow {
            id: toplevelsFlow
            spacing: 8
            padding: 4
            flow: root.panelVertical ?  Flow.TopToBottom : Flow.LeftToRight
            anchors.centerIn: parent

            Repeater {
              model: workspace.modelData.toplevels
              delegate: IconImage {
                id: toplevel
                required property HyprlandToplevel modelData 
                source: IconsMap.get(modelData.lastIpcObject.initialClass)
                implicitSize: 18

                Component.onCompleted: Hyprland.refreshToplevels()
              }
            }
          }
        }
      }
    }

  }
}
