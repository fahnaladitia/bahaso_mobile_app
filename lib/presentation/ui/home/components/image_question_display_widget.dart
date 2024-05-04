import 'package:bahaso_mobile_app/domain/models/models.dart';
import 'package:flutter/material.dart';

class ImageQuestionDisplayWidget extends StatelessWidget {
  final ImageQuestionDisplay questionDisplay;
  const ImageQuestionDisplayWidget({Key? key, required this.questionDisplay}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.network(questionDisplay.question),
        const SizedBox(height: 8),
      ],
    );
  }
}
