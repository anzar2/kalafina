pragma ComponentBehavior: Bound
import "../../"
import "../workspaces/"
import "../clock/"
import "../notifications/"
import "../systemtray/"
import "../../utils"
import "../audio/"
import QtQuick
import Quickshell.Wayland
import Quickshell.Hyprland


StyledPanelWindow {
  id: bar
  implicitHeight: Config.settings.panel.size
  background.radius: 0
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
      
      Audio {}
    }

    Clock {
      anchors.verticalCenter: parent.verticalCenter
    }
    Notifications {}
  }
}

