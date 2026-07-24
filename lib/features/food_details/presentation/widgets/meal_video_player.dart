import 'package:flutter/material.dart';
import '../../../../core/constants/color_manager.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class MealVideoPlayer extends StatefulWidget {
  const MealVideoPlayer({required this.videoUrl, super.key});
  final String videoUrl;

  @override
  State<MealVideoPlayer> createState() => MealVideoPlayerState();
}

class MealVideoPlayerState extends State<MealVideoPlayer> {
  late YoutubePlayerController _controller;
  bool _isReady = false;

  @override
  void initState() {
    super.initState();
    var videoId = '';

    final uri = Uri.tryParse(widget.videoUrl);
    if (uri != null) {
      if (uri.queryParameters.containsKey('v')) {
        videoId = uri.queryParameters['v']!;
      } else if (uri.pathSegments.isNotEmpty) {
        videoId = uri.pathSegments.last;
      }
    }

    _controller = YoutubePlayerController.fromVideoId(
      videoId: videoId,
      params: const YoutubePlayerParams(
        showFullscreenButton: true,
      ),
    );

    // Small delay to avoid a jarring flash while the player initializes.
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) setState(() => _isReady = true);
    });
  }

  @override
  Future<void> dispose() async {
    await _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.35),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          children: [
            AnimatedOpacity(
              opacity: _isReady ? 1 : 0,
              duration: const Duration(milliseconds: 300),
              child: YoutubePlayer(
                controller: _controller,
              ),
            ),
            if (!_isReady)
              const CircularProgressIndicator(
                color: AppColors.primary,
                strokeWidth: 2.5,
              ),
          ],
        ),
      ),
    );
  }
}