import 'package:bahaso_mobile_app/domain/models/models.dart';
import 'package:flutter/material.dart';

class TextQuestionDisplayWidget extends StatelessWidget {
  final TextQuestion questionDisplay;
  const TextQuestionDisplayWidget({Key? key, required this.questionDisplay}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(questionDisplay.question),
        const SizedBox(height: 8),
      ],
    );
  }
}
