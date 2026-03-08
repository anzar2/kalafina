pragma ComponentBehavior: Bound
import Quickshell
import QtQuick
import Quickshell.Services.Notifications
import "./components/layout/"
import "./components/osd/"
import "./widgets/"
import "./utils/"
import "./components/panels/"

ShellRoot {
  // Layout
  id: root

  Loader {
    id: shellFrame
    sourceComponent: ShellFrame {}
    active: Config.settings.shellFrame.enabled
  }

  Loader {
    id: topPanel
    sourceComponent: HPanel {
      anchors.top: true
      anchors.left: true
      anchors.right: true
    }
    active: (Config.settings.panel.position === "top")
  }

  Loader {
    id: leftPanel
    sourceComponent: VPanel { 
      anchors.top: true
      anchors.bottom: true
      anchors.left: true
    }
    active: (Config.settings.panel.position === "left")
  }

  Loader {
    id: rightPanel
    sourceComponent: VPanel { 
      anchors.top: true
      anchors.bottom: true
      anchors.right: true
    }
    active: (Config.settings.panel.position === "right")
  }

  Loader {
    id: bottomPanel
    sourceComponent: HPanel { 
      anchors.left: true
      anchors.bottom: true
      anchors.right: true
    }
    active: (Config.settings.panel.position === "bottom")
  }
  
  // Audio OSD
  AnimatedLoader {
    id: audioOsd
    loader.sourceComponent: AudioOSD {
      anchors.bottom: true

      HoverHandler {
        onHoveredChanged: {
          if (hovered) {
            osdTimer.stop()
          } else osdTimer.restart()
        }
      }
    }

    openAnimation: NumberAnimation {
      property: "margins.bottom"
      from: -Config.settings.panel.size + 20
      to: Config.settings.panel.size
      duration: 100
      easing.type: Easing.OutCubic
    }

    active: false
  
    Timer {
      id: osdTimer
      interval: Config.settings.osd.displayTime
      running: false
      repeat: false
      onTriggered: {
        if (audioOsd.active) {
          audioOsd.toggle()
        }
      }
    }

    Connections {
      target: AudioService

      function onVolumeChanged() {
        audioOsd.active = true
        osdTimer.restart()
      }

      function onMutedChanged() {
        audioOsd.active = true
        osdTimer.restart()
      }
    }
  }

  // Notifications
  AnimatedLoader {
    id: notificationWidgetLoader
    loader.sourceComponent: NotificationWidget {
      id: notificationWidget
      onMouseEntered: notificationTimer.stop()
      onMouseExited: notificationTimer.restart()
    }
    loader.onLoaded: notificationTimer.start() 
    active: NotificationService.properties.showPanel

    openAnimation: NumberAnimation {
      property: Config.settings.panel.position === "left" ? "margins.left" : "margins.right" 
      from: -500
      to: Config.settings.panel.position.match(/^(left|right)$/) ? 
          Config.settings.shellFrame.borderWidth + 5 : 
          Config.settings.shellFrame.borderWidth + 5

      duration: 150
      easing.type: Easing.OutSine
    }

    hideAnimation: NumberAnimation {
      property: Config.settings.panel.position === "left" ? "margins.left" : "margins.right" 
      from: 0
      to: -400
      easing.type: Easing.InOutSine
      duration: 250
    } 
    
    Connections {
      target: NotificationService.server

      function onNotification(notification) {
        if (!NotificationService.properties.dnd) {
          NotificationService.properties.showPanel = true
        }
      }
    }

    Timer {
      id: notificationTimer
      interval: Config.settings.notifications.displayTime
      running: false
      repeat: false
      onTriggered: {
        if (notificationWidgetLoader.active) {
          NotificationService.properties.showPanel = false
        }
      }
    }
  } 

  // Audio Widget
  AnimatedLoader {
    id: audioWidget
    loader.sourceComponent: AudioWidget {
      id: widget
      anchors.top: true
      anchors.right: true
      
    }
    active: AudioService.showAudioWidget

    openAnimation: NumberAnimation {
      properties: "margins.top"
      from: -400
      to: 10
    }
    
    hideAnimation: NumberAnimation {
      property: "margins.top"
      from: 10
      to: -400
    }
  }


}
