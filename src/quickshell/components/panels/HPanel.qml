pragma ComponentBehavior: Bound
import Quickshell
import QtQuick
import Quickshell.Wayland
import Quickshell.Hyprland
import "../../"
import "../workspaces/"
import "../clock/"
import "../notifications/"
import "../systemtray/"
import "../utils/"
import "../../widgets/"

PanelWindow {
  id: bar
  color: Colors.surface
  implicitHeight: Config.settings.panel.size
  WlrLayershell.namespace: "panel"
  WlrLayershell.layer: Hyprland.focusedMonitor?.activeWorkspace?.hasFullscreen ? WlrLayershell.Top : WlrLayershell.Overlay
  
  // Left modules
  Row {
    spacing: Config.settings.panel.start.moduleSpacing
    anchors.leftMargin: 16
    anchors.left: parent.left
    anchors.verticalCenter: parent.verticalCenter
    Workspaces {
      anchors.verticalCenter: parent.verticalCenter
    }
  }
  
  // Center modules
  Row {
    spacing: Config.settings.panel.center.moduleSpacing
    anchors.centerIn: parent
  }
  
  // // Right modules
  Row {
    id: rightModules
    spacing: Config.settings.panel.end.moduleSpacing
    anchors.verticalCenter: parent.verticalCenter
    anchors.rightMargin: 16
    anchors.right: parent.right
      
    TrayIcons {
      anchors.verticalCenter: parent.verticalCenter
    }

    Row {
      id: controlCenter
      spacing: 0
      anchors.verticalCenter: parent.verticalCenter
      
      StyledButton {
        id: sound
        nerdIcon.text: {
          if (AudioService.volume > 50) return "󰕾"
          if (AudioService.volume > 10) return "󰖀"
          return "󰕿"
        }
        onClicked: AudioService.toggleAudioWidget()
        backgroundRect.color: hovered || AudioService.showAudioWidget ? Colors.surface_container_high : "transparent"
      }
    }
       
    Clock {}
    Notifications {}
  }
}

