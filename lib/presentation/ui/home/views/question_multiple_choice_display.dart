import 'package:bahaso_mobile_app/domain/models/models.dart';

import 'package:flutter/material.dart';

import '../components/audio_question_display_widget.dart';
import '../components/image_question_display_widget.dart';
import '../components/text_question_display_widget.dart';
import '../components/video_question_display_widget.dart';

class QuestionMultipleChoiceDisplay extends StatefulWidget {
  final MultipleChoiceQuestion question;
  const QuestionMultipleChoiceDisplay({
    Key? key,
    required this.question,
  }) : super(key: key);

  @override
  State<QuestionMultipleChoiceDisplay> createState() => _QuestionMultipleChoiceDisplayState();
}

class _QuestionMultipleChoiceDisplayState extends State<QuestionMultipleChoiceDisplay> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.question.questionNumber.toString()),
            const SizedBox(height: 8),
            _buildQuestion(),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestion() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(widget.question.questionDisplays.length, (index) {
        final questionDisplay = widget.question.questionDisplays[index];
        final isBeforeAudioQuestionIsImageQuestion = index > 0 &&
            widget.question.questionDisplays[index - 1] is ImageQuestion &&
            questionDisplay is AudioQuestion;
        final isAfterImageQuestionIsAudioQuestion = index < widget.question.questionDisplays.length - 1 &&
            questionDisplay is ImageQuestion &&
            widget.question.questionDisplays[index + 1] is AudioQuestion;

        switch (questionDisplay.runtimeType) {
          case TextQuestion:
            return TextQuestionDisplayWidget(questionDisplay: questionDisplay as TextQuestion);
          case ImageQuestion:
            return isAfterImageQuestionIsAudioQuestion
                ? const SizedBox.shrink()
                : ImageQuestionDisplayWidget(questionDisplay: questionDisplay as ImageQuestion);
          case AudioQuestion:
            final audioQuestion = questionDisplay as AudioQuestion;
            final imageQuestion = isBeforeAudioQuestionIsImageQuestion
                ? widget.question.questionDisplays[index - 1] as ImageQuestion
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
          case VideoQuestion:
            return VideoQuestionDisplayWidget(videoQuestionDisplay: questionDisplay as VideoQuestion);
          default:
            return const SizedBox.shrink();
        }
      }),
    );
  }
}
