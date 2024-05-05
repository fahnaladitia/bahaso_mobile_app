import 'package:bahaso_mobile_app/domain/models/models.dart';
import 'package:flutter/material.dart';

import '../components/audio_question_display_widget.dart';
import '../components/image_question_display_widget.dart';
import '../components/multiple_text_question_display_widget.dart';
import '../components/puzzle_text_question_display_widget.dart';
import '../components/text_question_display_widget.dart';
import '../components/video_question_display_widget.dart';

class BuildDisplayQuestion extends StatelessWidget {
  final Question question;
  const BuildDisplayQuestion({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(context),
          _buildQuestion(),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    final style = Theme.of(context).textTheme.titleMedium;
    switch (question.runtimeType) {
      case PuzzleTextQuestion:
        final puzzleTextQuestion = question as PuzzleTextQuestion;
        return Text("${puzzleTextQuestion.questionNumber}.", style: style);
      case DescriptionQuestion:
        final descriptionQuestion = question as DescriptionQuestion;
        return Text("${descriptionQuestion.questionNumber}.", style: style);
      case MultipleChoiceQuestion:
        final multipleChoiceQuestion = question as MultipleChoiceQuestion;
        return Text("${multipleChoiceQuestion.questionNumber}.", style: style);
      case TrueFalseQuestion:
        final trueFalseQuestion = question as TrueFalseQuestion;
        return Text("${trueFalseQuestion.questionNumber}.", style: style);
      case MatchQuestion:
        final matchQuestion = question as MatchQuestion;
        return Text("${matchQuestion.questionNumber}.", style: style);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildQuestion() {
    switch (question.runtimeType) {
      case MatchQuestion:
        final matchQuestion = question as MatchQuestion;
        final choices = matchQuestion.choices;
        final display = matchQuestion.questionDisplays.firstOrNull;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (display is TextQuestionDisplay) TextQuestionDisplayWidget(questionDisplay: display),
            MultipleTextQuestionDisplayWidget(
              questionData: matchQuestion.selectedData,
              questionDisplay: choices,
            ),
          ],
        );
      default:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(question.questionDisplays.length, (index) {
            final questionDisplay = question.questionDisplays[index];
            switch (questionDisplay.runtimeType) {
              case TextQuestionDisplay:
                return TextQuestionDisplayWidget(questionDisplay: questionDisplay as TextQuestionDisplay);
              case ImageQuestionDisplay:
                return ImageQuestionDisplayWidget(questionDisplay: questionDisplay as ImageQuestionDisplay);
              case AudioQuestionDisplay:
                return AudioQuestionDisplayWidget(audioQuestionDisplay: questionDisplay as AudioQuestionDisplay);
              case VideoQuestionDisplay:
                return VideoQuestionDisplayWidget(videoQuestionDisplay: questionDisplay as VideoQuestionDisplay);
              case PuzzleTextQuestionDisplay:
                final display = questionDisplay as PuzzleTextQuestionDisplay;
                if (question is PuzzleTextQuestion) {
                  return PuzzleTextQuestionDisplayWidget(
                    questionDisplay: display,
                    question: question as PuzzleTextQuestion,
                  );
                }
                return Container();
              default:
                return Container();
            }
          }).toList(),
        );
    }
  }
}
