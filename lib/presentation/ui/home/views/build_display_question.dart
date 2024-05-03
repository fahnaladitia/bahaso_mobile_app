import 'package:bahaso_mobile_app/domain/models/models.dart';
import 'package:flutter/material.dart';

import '../components/audio_question_display_widget.dart';
import '../components/image_question_display_widget.dart';
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
          const SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(question.questionDisplays.length, (index) {
              final questionDisplay = question.questionDisplays[index];
              final isBeforeAudioQuestionIsImageQuestion = index > 0 &&
                  question.questionDisplays[index - 1] is ImageQuestionDisplay &&
                  questionDisplay is AudioQuestionDisplay;
              final isAfterImageQuestionIsAudioQuestion = index < question.questionDisplays.length - 1 &&
                  questionDisplay is ImageQuestionDisplay &&
                  question.questionDisplays[index + 1] is AudioQuestionDisplay;

              switch (questionDisplay.runtimeType) {
                case TextQuestionDisplay:
                  return TextQuestionDisplayWidget(questionDisplay: questionDisplay as TextQuestionDisplay);
                case ImageQuestionDisplay:
                  return isAfterImageQuestionIsAudioQuestion
                      ? const SizedBox.shrink()
                      : ImageQuestionDisplayWidget(questionDisplay: questionDisplay as ImageQuestionDisplay);
                case AudioQuestionDisplay:
                  final audioQuestion = questionDisplay as AudioQuestionDisplay;
                  final imageQuestion = isBeforeAudioQuestionIsImageQuestion
                      ? question.questionDisplays[index - 1] as ImageQuestionDisplay
                      : null;
                  return isBeforeAudioQuestionIsImageQuestion && imageQuestion != null
                      ? ImageQuestionDisplayWidget(
                          questionDisplay: imageQuestion,
                          audioQuestionDisplay: audioQuestion,
                        )
                      : Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: AudioQuestionDisplayWidget(audioQuestionDisplay: audioQuestion),
                        );
                case VideoQuestionDisplay:
                  return VideoQuestionDisplayWidget(videoQuestionDisplay: questionDisplay as VideoQuestionDisplay);
                case PuzzleTextQuestionDisplay:
                  final display = questionDisplay as PuzzleTextQuestionDisplay;
                  final start = display.placesIds.first;
                  final end = display.placesIds.last;
                  final image = display.imageSlots.isNotEmpty
                      ? (question as PuzzleTextQuestion)
                          .images
                          .getRange(display.imageSlots.first, display.imageSlots.last + 1)
                          .toList()
                          .firstOrNull
                      : null;
                  return PuzzleTextQuestionDisplayWidget(
                    questionDisplay: display,
                    image: image,
                    places: (question as PuzzleTextQuestion).places.getRange(start, end + 1).toList(),
                  );
                default:
                  return Container();
              }
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    switch (question.runtimeType) {
      case PuzzleTextQuestion:
        final puzzleTextQuestion = question as PuzzleTextQuestion;
        return Text("${puzzleTextQuestion.questionNumber}.");
      case DescriptionQuestion:
        final descriptionQuestion = question as DescriptionQuestion;
        return Text("${descriptionQuestion.questionNumber}.");
      case MultipleChoiceQuestion:
        final multipleChoiceQuestion = question as MultipleChoiceQuestion;
        return Text("${multipleChoiceQuestion.questionNumber}.");
      case TrueFalseQuestion:
        final trueFalseQuestion = question as TrueFalseQuestion;
        return Text("${trueFalseQuestion.questionNumber}.");
      case MatchQuestion:
        final matchQuestion = question as MatchQuestion;
        return Text("${matchQuestion.questionNumber}.");
      default:
        return const SizedBox.shrink();
    }
  }
}
