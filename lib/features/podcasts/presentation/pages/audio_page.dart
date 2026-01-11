import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jolly_podcast/features/podcasts/domain/entities/audio_position_entity.dart';
import 'package:jolly_podcast/features/podcasts/presentation/widgets/audio_controls.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

class AudioPage extends StatefulWidget {
  final String contentUrl;
  final String pictureUrl;
  final String title;
  final String description;
  const AudioPage({
    super.key,
    required this.contentUrl,
    required this.pictureUrl,
    required this.description,
    required this.title,
  });

  @override
  State<AudioPage> createState() => _AudioPageState();
}

class _AudioPageState extends State<AudioPage> {
  late AudioPlayer _audioPlayer;

  Stream<AudioPositionEntity> get _audioPositionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, AudioPositionEntity>(
        _audioPlayer.positionStream,
        _audioPlayer.bufferedPositionStream,
        _audioPlayer.durationStream,
        (position, bufferedPosition, duration) => AudioPositionEntity(
          position: position,
          bufferedPosition: bufferedPosition,
          duration: duration ?? Duration.zero,
        ),
      );

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer()
      ..setUrl(widget.contentUrl)
      ..play();
  }

  @override
  void dispose() {
    super.dispose();
    _audioPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,

        // * APPBAR
        appBar: AppBar(
          toolbarHeight: 50,
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          title: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: SvgPicture.asset('assets/svg/chevron_down_circle.svg'),
          ),
        ),

        // * BODY
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1DB954), Color(0xFF064920)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.7, 1.0],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30, top: 70),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // * PODCAST PICTURE
                    Container(
                      height: 321,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(widget.pictureUrl),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // * TITLE
                    Text(
                      widget.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.nunito(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),

                    // * DESCRIPTION
                    Text(
                      widget.description,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.nunito(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 27),

                    // * SEEK
                    StreamBuilder<AudioPositionEntity>(
                      stream: _audioPositionDataStream,
                      builder: (context, snapshot) {
                        final audioPositionData = snapshot.data;
                        return ProgressBar(
                          progress:
                              audioPositionData?.position ?? Duration.zero,
                          total: audioPositionData?.duration ?? Duration.zero,
                          buffered: audioPositionData?.bufferedPosition,
                          onSeek: _audioPlayer.seek,
                          progressBarColor: Color(0xFF1DB954),
                          baseBarColor: Colors.black.withOpacity(0.3),
                          timeLabelType: TimeLabelType.remainingTime,
                          timeLabelTextStyle: GoogleFonts.nunito(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Color(0XFFE4E4E4),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),

                    AudioControls(audioPlayer: _audioPlayer),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
