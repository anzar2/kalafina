pragma Singleton
import Quickshell.Io
import QtQuick
import Quickshell
import Quickshell.Hyprland

FileView {
  id: root
  property alias settings: jsonAdapter

  path: `${Quickshell.env("HOME")}/.config/quickshell/shell.json`
  watchChanges: true
  onFileChanged: reload()
  onAdapterUpdated: writeAdapter()

  JsonAdapter {
    id: jsonAdapter
    property string _currentTheme: "unset"
    property string theme: "unset" // dark | light
    property string color: "auto" // <hex_color> | auto
    property string fontFamily: "Arial"
    property real fontScale: 1

    onThemeChanged: {
      if (theme === "unset") return;

      if (_currentTheme === "unset") {
        _currentTheme = theme
        return
      }

      _currentTheme = theme
      Quickshell.execDetached(["sh", "-c", "$HOME/.config/quickshell/scripts/change_theme.sh " + theme])
    }

    property JsonObject shellFrame: JsonObject {
      property bool enabled: true
      property real borderWidth: 4
      property real borderRadius: 4
    }

    property JsonObject panel: JsonObject {
      property string position: "" // top | bottom | right | left
      property int size: 30

      property JsonObject start: JsonObject {
        property int moduleSpacing: 8
      }
      
      property JsonObject center: JsonObject {
        property int moduleSpacing: 8
      }  

      property JsonObject end: JsonObject {
        property int moduleSpacing: 8
      }

    }

    property JsonObject clock: JsonObject {
      property string horizontalFormat: "hh:mm"
      property string verticalFormat: "hh mm"
      property real fontSize: 16 
      property bool bold: true
      property string fontFamily: "Agave Nerd Font"
    }

    property JsonObject workspaces: JsonObject {
      property real indicatorSpacing: 8
      property real padding: 6
      property real indicatorSize: 8
      property real indicatorRadius: 10
      property real borderRadius: 4
    }

    property JsonObject systemTray: JsonObject {
      property real padding: 4
      property real spacing: 8
      property real iconSize: 16
    }

    property JsonObject osd: JsonObject {
      property JsonObject position: JsonObject {
        property bool top: false
        property bool bottom: false
        property bool right: false
        property bool left: false
      }
      property int displayTime: 2000
    }

    property JsonObject notifications: JsonObject {
      property JsonObject anchors: JsonObject {
        property bool top: true
        property bool right: true
        property bool left: false
        property bool bottom: false
      }
    }
  }
}
