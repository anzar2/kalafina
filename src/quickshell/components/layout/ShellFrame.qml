import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import QtQuick.Effects
import "../../"

PanelWindow {
    id: root

    color: "transparent"
    visible: true
    WlrLayershell.layer: WlrLayer.Top

    mask: Region { 
        item: container
        intersection: Intersection.Xor 
    }

    anchors {
        top: true
        left: true
        bottom: true
        right: true
    }

    Item {
        id: container
        anchors.fill: parent

        Rectangle {
            id: background
            anchors.fill: parent
            color: Theme.colors.surface

            layer.enabled: true
            layer.effect: MultiEffect {
                maskSource: mask
                maskEnabled: true
                maskInverted: true
                maskThresholdMin: 0.5
                maskSpreadAtMin: 1
            }
            Behavior on color { ColorAnimation {} }
        }

        Item {
            id: mask
            anchors.fill: parent
            layer.enabled: true
            visible: false

            Rectangle {
                anchors.fill: parent
                anchors.leftMargin: Config.settings.panel.position === "left"       ? 0 : Config.settings.shellFrame.borderWidth
                anchors.rightMargin: Config.settings.panel.position === "right"     ? 0 : Config.settings.shellFrame.borderWidth
                anchors.topMargin: Config.settings.panel.position === "top"         ? 0 : Config.settings.shellFrame.borderWidth
                anchors.bottomMargin: Config.settings.panel.position === "bottom"   ? 0 : Config.settings.shellFrame.borderWidth
                radius: Config.settings.shellFrame.borderRadius
            }
        }
    }
}
