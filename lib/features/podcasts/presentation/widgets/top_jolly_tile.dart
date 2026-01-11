import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jolly_podcast/core/widgets/touchable_opacity.dart';
import 'package:jolly_podcast/features/podcasts/presentation/widgets/podcast_tile_cta_button.dart';

class TopJollyTile extends StatelessWidget {
  final String author;
  final String title;
  final String pictureUrl;
  final void Function()? onTap;

  const TopJollyTile({
    super.key,
    required this.author,
    required this.title,
    required this.pictureUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Color(0XFF232020),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // * PODCAST THUMBNAIL
          TouchableOpacity(
            onTap: onTap,
            child: Container(
              height: 133,
              width: 171,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(pictureUrl),
                  fit: BoxFit.cover,
                  onError: (exception, stackTrace) {
                    debugPrint('Failed to load podcast image: $exception');
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),

          // * PODCAST NAME
          Text(
            title.length > 20 ? '${title.substring(0, 20)}...' : title,
            style: GoogleFonts.nunito(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),

          // * AUTHOR
          Text(
            'By: $author',
            style: GoogleFonts.nunito(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Color(0XFFA7A7A7),
            ),
          ),
          const SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // * Follow button
              Container(
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: Color(0XFF585454),
                ),
                child: Row(
                  children: [
                    Icon(Icons.add_circle, color: Color(0XFFE4E4E4)),
                    const SizedBox(width: 4),
                    Text(
                      'Follow',
                      style: GoogleFonts.nunito(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Color(0XFFA7A7A7),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),

              // * CTA button
              PodcastTileCtaButton(
                icon: Icon(Icons.share, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
