import 'package:just_audio/just_audio.dart';
import 'package:fun_button/utilities/audio.dart';

// This class is a concrete implementation of the Audio abstract class.
class JustAudioPlayer implements Audio {
  final player = AudioPlayer();

  @override
  Future<Object?> play(String src) {
    return player.setAsset('sounds/click1.mp3').then((value) => player.play());
  }

  @override
  void dispose() {
    //player.dispose();
  }
}
