import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jolly_podcast/core/constants/utils.dart';
import 'package:jolly_podcast/core/widgets/touchable_opacity.dart';
import 'package:jolly_podcast/features/podcasts/presentation/widgets/podcast_tile_cta_button.dart';

class PodcastTile extends StatelessWidget {
  final String author;
  final String title;
  final String description;
  final String pictureUrl;
  final void Function()? onTap;
  const PodcastTile({
    super.key,
    required this.author,
    required this.description,
    required this.title,
    required this.pictureUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: 288,
      height: 500,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: NetworkImage(pictureUrl),
          fit: BoxFit.cover,
          onError: (exception, stackTrace) {
            debugPrint('Failed to load podcast image: $exception');
          },
        ),
      ),
      child: Stack(
        children: [
          // * GRADIENT EFFECT
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),

              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.3),

                  Color(0XFF152A16).withOpacity(1),
                  Color(0XFF152A16).withOpacity(1),
                ],
              ),
            ),
          ),

          // * MAIN CONTENT
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // * IMAGE WITH PLAY BUTTON
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(pictureUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TouchableOpacity(
                          onTap: onTap,
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: context.colorScheme.primary
                                .withOpacity(0.6),
                            child: Icon(Icons.play_arrow, size: 40),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // * AUTHOR
                  Text(
                    author,
                    style: GoogleFonts.nunito(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Color(0XFFA7A7A7),
                    ),
                  ),

                  // * TITLE
                  Text(
                    title,
                    style: GoogleFonts.nunito(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),

                  // * EPISODE DESCRIPTION
                  Text(
                    description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.nunito(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Color(0XFFCECECE),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // * CTA BUTTONS
                  Row(
                    children: [
                      PodcastTileCtaButton(
                        icon: Icon(Icons.favorite, color: Colors.white),
                      ),
                      const SizedBox(width: 10),
                      PodcastTileCtaButton(
                        icon: SvgPicture.asset(
                          'assets/svg/rectangle_history.svg',
                        ),
                      ),
                      const SizedBox(width: 10),

                      PodcastTileCtaButton(
                        icon: Icon(Icons.share, color: Colors.white),
                      ),
                      const SizedBox(width: 10),

                      PodcastTileCtaButton(
                        icon: Icon(Icons.add_circle, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
