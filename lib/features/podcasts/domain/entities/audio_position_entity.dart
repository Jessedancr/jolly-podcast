class AudioPositionEntity {
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;

  AudioPositionEntity({
    required this.position,
    required this.bufferedPosition,
    required this.duration,
  });
}
