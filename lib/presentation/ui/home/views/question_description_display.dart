import 'package:bahaso_mobile_app/domain/models/models.dart';
import 'package:flutter/material.dart';

import 'build_display_question.dart';

class QuestionDescriptionDisplay extends StatefulWidget {
  final DescriptionQuestion question;
  const QuestionDescriptionDisplay({Key? key, required this.question}) : super(key: key);

  @override
  State<QuestionDescriptionDisplay> createState() => _QuestionDescriptionDisplayState();
}

class _QuestionDescriptionDisplayState extends State<QuestionDescriptionDisplay> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.question.questionNumber),
          const SizedBox(height: 8),
          BuildDisplayQuestion(question: widget.question),
        ],
      ),
    );
  }
}
