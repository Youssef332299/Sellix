import 'package:audioplayers/audioplayers.dart';
import 'package:sellix/core/assets/sounds.dart';

// class KitchenSoundService {
//
//   final _player = AudioPlayer();
//
//   Future newOrder() async{
//     await _player.play(
//         AssetSource(notification));
//   }
//
//   Future preparing() async{
//     await _player.play(
//         AssetSource(swipe));
//   }
//   Future intro() async{
//     await _player.play(
//         AssetSource(introSound));
//   }
//   Future pop() async{
//     await _player.play(
//         AssetSource(popSound));
//   }
//   Future speedSwipe() async{
//     await _player.play(
//         AssetSource(speed_swipe));
//   }
//
//   Future ready() async{
//     await _player.play(
//         AssetSource(click));
//   }
// }
class KitchenSoundService {
  final _player = AudioPlayer()..setReleaseMode(ReleaseMode.stop);

  Future play(String path) async {
    await _player.stop();
    await _player.play(AssetSource(path));
  }

  Future newOrder() => play(notification);
  Future preparing() => play(swipe);
  Future ready() => play(click);
}
