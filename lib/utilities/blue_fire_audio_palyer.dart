import 'package:audioplayers/audioplayers.dart';
import 'package:fun_button/utilities/audio.dart';

// This class is a concrete implementation of the Audio abstract class.
class BlueFireAudioPlayer implements Audio {
  var player = AudioPlayer();

  @override
  void play(String src) {
    player.play(AssetSource(src));
  }

  @override
  void dispose() {
    player.dispose();
  }
}
