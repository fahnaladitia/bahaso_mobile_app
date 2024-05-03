import 'package:bahaso_mobile_app/domain/models/models.dart';
import 'package:flutter/material.dart';

import 'build_display_question.dart';

class QuestionPuzzleTextDisplay extends StatefulWidget {
  final PuzzleTextQuestion question;
  const QuestionPuzzleTextDisplay({Key? key, required this.question}) : super(key: key);

  @override
  State<QuestionPuzzleTextDisplay> createState() => _QuestionPuzzleTextDisplayState();
}

class _QuestionPuzzleTextDisplayState extends State<QuestionPuzzleTextDisplay> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.question.questionNumber.toString()),
          const SizedBox(height: 8),
          BuildDisplayQuestion(question: widget.question),
        ],
      ),
    );
  }
}
