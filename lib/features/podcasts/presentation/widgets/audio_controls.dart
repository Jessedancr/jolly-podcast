import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jolly_podcast/core/widgets/touchable_opacity.dart';
import 'package:just_audio/just_audio.dart';

class AudioControls extends StatelessWidget {
  final AudioPlayer audioPlayer;
  const AudioControls({super.key, required this.audioPlayer});

  void skipTenSeconds() {
    final currentPosition = audioPlayer.position;
    final duration = audioPlayer.duration;
    if (duration != null) {
      final newPosition = currentPosition + Duration(seconds: 10);
      audioPlayer.seek(newPosition > duration ? duration : newPosition);
    }
  }

  void rewindTenSeconds() {
    final currentPosition = audioPlayer.position;
    final duration = audioPlayer.duration;

    if (duration != null) {
      final newPosition = currentPosition - Duration(seconds: 10);
      audioPlayer.seek(newPosition);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlayerState>(
      stream: audioPlayer.playerStateStream,
      builder: (context, snapshot) {
        final playerState = snapshot.data;
        final playing = playerState?.playing;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SvgPicture.asset('assets/svg/back_arrow.svg'),
            TouchableOpacity(
              onTap: rewindTenSeconds,
              child: SvgPicture.asset('assets/svg/back_ten_sec.svg'),
            ),
            if (playing ?? false)
              PlayPauseButton(
                onTap: audioPlayer.pause,
                child: Icon(Icons.pause_rounded, color: Colors.white),
              )
            else
              PlayPauseButton(
                onTap: audioPlayer.play,
                child: Icon(Icons.play_arrow_rounded, color: Colors.white),
              ),
            TouchableOpacity(
              onTap: skipTenSeconds,
              child: SvgPicture.asset('assets/svg/forward_ten_sec.svg'),
            ),
            SvgPicture.asset('assets/svg/forward_arrow.svg'),
          ],
        );
      },
    );
  }
}

class PlayPauseButton extends StatelessWidget {
  final Widget child;
  final void Function()? onTap;
  const PlayPauseButton({super.key, required this.child, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onTap: onTap,
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: Color(0xFF1DB954),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 2.0, color: Colors.white),
        ),
        child: Center(child: child),
      ),
    );
  }
}
