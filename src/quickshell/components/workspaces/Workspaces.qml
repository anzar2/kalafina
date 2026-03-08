pragma ComponentBehavior: Bound
import QtQuick
import Quickshell.Widgets
import Quickshell.Hyprland
import "../.."
import "../../utils/"

Rectangle {
  id: root
  property bool panelVertical: Config.settings.panel.isVertical()
  property int sizeMargin: 16

  implicitWidth: panelVertical ? Config.settings.panel.size - sizeMargin : workspacesFlow.width
  implicitHeight: panelVertical ? workspacesFlow.height : Config.settings.panel.size - sizeMargin
  color: Qt.alpha(Theme.colors.primary, 0.1)
  radius: Config.settings.workspaces.radius

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
    padding: 12
    spacing: Config.settings.workspaces.workspaceSpacing
    flow: root.panelVertical ?  Flow.TopToBottom : Flow.LeftToRight
 
    Repeater {
      model: Hyprland.workspaces.values.filter(ws => ws.id > 0)
      delegate: Item {
        id: workspace
        required property HyprlandWorkspace modelData
        property bool isFocused: modelData.id === Hyprland.focusedWorkspace.id
        property int toplevelsCount: modelData.toplevels.values.length
        implicitWidth: root.panelVertical ? root.width : indicator.width
        implicitHeight: root.panelVertical ? indicator.height : root.height
          
        TapHandler { onSingleTapped: workspace.modelData.activate() }
        HoverHandler { id: hoverHandler; cursorShape: Qt.PointingHandCursor }

        Rectangle {
          id: indicator
          implicitWidth: workspace.isFocused || workspace.toplevelsCount > 0 ? toplevelsFlow.width : 8
          implicitHeight: workspace.isFocused || workspace.toplevelsCount > 0 ? toplevelsFlow.height : 8
          radius: root.radius
          color: workspace.isFocused || hoverHandler.hovered ? Qt.alpha(Theme.colors.on_surface, 0.3) : Qt.alpha(Theme.colors.primary, 0.1)
          anchors.centerIn: parent
          
          Behavior on implicitHeight { NumberAnimation { duration: 100; easing.type: Easing.OutQuad } }
          Behavior on implicitWidth { NumberAnimation { duration: 100; easing.type: Easing.OutQuad } }
          Behavior on color { ColorAnimation { duration: 100; easing.type: Easing.OutQuad } }
                   
          Flow {
            id: toplevelsFlow
            spacing: Config.settings.workspaces.iconSpacing
            padding: 4
            flow: root.panelVertical ?  Flow.TopToBottom : Flow.LeftToRight
            anchors.centerIn: parent

            Repeater {
              model: workspace.modelData.toplevels
              delegate: IconImage {
                id: toplevel
                required property HyprlandToplevel modelData 
                source: IconsMap.get(modelData.lastIpcObject.initialClass)
                implicitSize: {
                  if (Config.settings.workspaces.iconSize > 0) { // This means automatic sizing
                    return Config.settings.workspaces.iconSize
                  }
                  return 16
                }
                Component.onCompleted: { 
                  Hyprland.refreshToplevels() 
                  console.log(IconsMap.get(modelData.lastIpcObject.initialClass))
                }
              }
            }
          }
        }
      }
    }

  }
}
