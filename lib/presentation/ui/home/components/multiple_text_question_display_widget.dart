import 'package:bahaso_mobile_app/domain/models/models.dart';
import 'package:flutter/material.dart';

class MultipleTextQuestionDisplayWidget extends StatelessWidget {
  final Map<QuestionDataText, String> questionData;
  final List<QuestionDataText> questionDisplay;
  const MultipleTextQuestionDisplayWidget({
    Key? key,
    required this.questionData,
    required this.questionDisplay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildQuestion(context),
        const SizedBox(height: 8),
      ],
    );
  }

  _buildQuestion(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: questionDisplay.map((question) {
        final answer = questionData[question];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (answer != null && answer.isNotEmpty)
              Text(question.text.replaceAll("___", answer))
            else
              Text(question.text),
            const SizedBox(height: 8),
          ],
        );
      }).toList(),
    );
  }
}
