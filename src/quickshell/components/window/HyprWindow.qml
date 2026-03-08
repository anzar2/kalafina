import Quickshell
import QtQuick
import Quickshell.Hyprland
import "../../"

Text {
  text: Hyprland.activeToplevel.title
  color: Colors.on_surface
}
