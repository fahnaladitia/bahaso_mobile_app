import 'package:bahaso_mobile_app/domain/models/models.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoQuestionDisplayWidget extends StatefulWidget {
  final VideoQuestionDisplay videoQuestionDisplay;
  const VideoQuestionDisplayWidget({Key? key, required this.videoQuestionDisplay}) : super(key: key);

  @override
  State<VideoQuestionDisplayWidget> createState() => _VideoQuestionDisplayWidgetState();
}

class _VideoQuestionDisplayWidgetState extends State<VideoQuestionDisplayWidget> {
  late final VideoPlayerController _controller;

  bool showPlayButton = true;

  Duration get durationDisplayPlayButton => const Duration(milliseconds: 3000);

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.networkUrl(widget.videoQuestionDisplay.url)
      ..initialize().then((_) {
        setState(() {});
      });

    _controller.addListener(() {
      if (_controller.value.isPlaying) {
        Future.delayed(durationDisplayPlayButton).then((value) {
          if (mounted) {
            setState(() {
              showPlayButton = false;
            });
          }
        });
      } else {
        setState(() {
          showPlayButton = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _controller.value.isInitialized
            ? Stack(
                children: [
                  AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ),
                  Positioned.fill(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          if (_controller.value.isPlaying) {
                            _controller.pause();
                          } else {
                            _controller.play();
                          }
                        });
                      },
                      child: Container(
                        color: _controller.value.isPlaying ? Colors.transparent : Colors.black.withOpacity(0.5),
                        child: showPlayButton || !_controller.value.isPlaying
                            ? Center(
                                child: Icon(
                                  _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                                  color: Colors.white,
                                ),
                              )
                            : const SizedBox.shrink(),
                      ),
                    ),
                  ),
                ],
              )
            : const CircularProgressIndicator(),
        const SizedBox(height: 8),
      ],
    );
  }
}
