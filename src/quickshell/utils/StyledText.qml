import QtQuick
import ".."

Text {
  property real scale: Config.settings.fontScale
  property real size: 12.0

  color: Theme.colors.on_surface
  font.family: Config.settings.fontFamily
  font.pointSize: scale * size
}
