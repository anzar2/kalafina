import "../../"
import "../workspaces/"
import "../clock/"
import "../systemtray/"
import "../notifications/"
import Quickshell
import QtQuick
import Quickshell.Wayland
import Quickshell.Hyprland

PanelWindow {
  id: bar
  color: Colors.surface
  implicitWidth: Config.settings.panel.size
  WlrLayershell.namespace: "panel"
  WlrLayershell.layer: Hyprland.focusedMonitor.activeWorkspace.hasFullscreen ? WlrLayershell.Top : WlrLayershell.Overlay

  // Left modules
  Column {
    spacing: Config.settings.panel.start.moduleSpacing
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top
    anchors.topMargin: 8
    Workspaces {}
  }

  // Center modules
  Column {
    spacing: Config.settings.panel.center.moduleSpacing
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.centerIn: parent
  }
  
  // Right modules
  Column {
    spacing: Config.settings.panel.end.moduleSpacing
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.bottom: parent.bottom
    anchors.bottomMargin: 8
    

    TrayIcons {
      anchors.horizontalCenter: parent.horizontalCenter
    }
    Clock {
      anchors.horizontalCenter: parent.horizontalCenter
    }
    Notifications {
      anchors.horizontalCenter: parent.horizontalCenter
    }
  }
}

