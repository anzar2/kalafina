pragma Singleton
import Quickshell.Services.Pipewire
import QtQuick

Item {
  id: root
  property var audioSink: Pipewire.defaultAudioSink ?? null
  property bool muted: audioSink?.audio.muted ?? false
  property real rawVolume: audioSink?.audio.volume ?? 0
  property real volume: Math.round(rawVolume * 100)
  property var outputDevices: Pipewire.nodes.values.filter(device => device.isSink && !device.isStream)
  property bool showAudioWidget: false

  onAudioSinkChanged: {
    setAudioOutput(audioSink)
  }

  function setAudioSource(input) {
    Pipewire.preferredDefaultAudioSource = input
  }

  function toggleMute() {
    Pipewire.defaultAudioSink.audio.muted = !Pipewire.defaultAudioSink?.audio.muted
  }

  function toggleAudioWidget() {
    showAudioWidget = !showAudioWidget
  }

  function setAudioOutput(sink) {
    Pipewire.preferredDefaultAudioSink = sink
  }

  function setVolume(volume) {
    Pipewire.defaultAudioSink.audio.volume = volume / 100
  }

    
  PwObjectTracker {
    objects: [Pipewire.defaultAudioSink]
  }
}
