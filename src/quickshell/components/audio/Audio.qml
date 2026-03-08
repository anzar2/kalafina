import "../../utils"
import "../.."
import QtQuick


StyledButton {
  id: sound
  nerdIcon.text: {
    if (AudioService.volume > 50) return "󰕾"
    if (AudioService.volume > 10) return "󰖀"
    return "󰕿"
  }
  onClicked: AudioService.toggleAudioWidget()
  backgroundRect.color: hovered || AudioService.showAudioWidget ? Theme.colors.surface_container_high : "transparent" 
}
