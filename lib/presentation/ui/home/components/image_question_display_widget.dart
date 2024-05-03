import 'package:bahaso_mobile_app/domain/models/models.dart';
import 'package:flutter/material.dart';

import 'audio_question_display_widget.dart';

class ImageQuestionDisplayWidget extends StatelessWidget {
  final ImageQuestion questionDisplay;
  final AudioQuestion? audioQuestionDisplay;
  const ImageQuestionDisplayWidget({Key? key, required this.questionDisplay, this.audioQuestionDisplay})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          children: [
            Image.network(questionDisplay.question),
            if (audioQuestionDisplay != null)
              Positioned(
                bottom: 16,
                right: 0,
                left: 0,
                child: Center(child: AudioQuestionDisplayWidget(audioQuestionDisplay: audioQuestionDisplay!)),
              ),
          ],
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
