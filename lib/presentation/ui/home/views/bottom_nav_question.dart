import 'package:bahaso_mobile_app/core/common/constants.dart';
import 'package:bahaso_mobile_app/domain/models/models.dart';
import 'package:bahaso_mobile_app/presentation/components/components.dart';
import 'package:bahaso_mobile_app/presentation/ui/home/bloc/questions_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavQuestion extends StatelessWidget {
  final List<Question> questions;
  final int currentIndex;
  const BottomNavQuestion({
    Key? key,
    required this.questions,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    logger.d('${questions.length} - $currentIndex');
    final bool isLastQuestion = currentIndex == questions.length - 1;
    final bool isFirstQuestion = currentIndex == 0;
    final bool isCurrentIsFilled = questions[currentIndex] is MultipleChoiceQuestion &&
            (questions[currentIndex] as MultipleChoiceQuestion).isAnswered() ||
        questions[currentIndex] is DescriptionQuestion;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildChoices(context),
        const Divider(),
        Row(
          children: [
            // Navigation buttons
            Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (!isFirstQuestion) {
                        context.read<QuestionsBloc>().add(QuestionsPreviousEvent());
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: isFirstQuestion ? Colors.grey : Colors.blue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      width: 48,
                      height: 48,
                      child: const Icon(Icons.arrow_back, size: 24, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      if (!isLastQuestion && isCurrentIsFilled) {
                        context.read<QuestionsBloc>().add(QuestionsNextEvent());
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: isLastQuestion || !isCurrentIsFilled ? Colors.grey : Colors.blue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      width: 48,
                      height: 48,
                      child: const Icon(Icons.arrow_forward, size: 24, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListViewHorizontal(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  final question = questions[index];
                  return _buildQuestionIndicator(context, index, question);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuestionIndicator(
    BuildContext context,
    int index,
    Question question,
  ) {
    final isSelected = index == currentIndex;
    final isAnsweredOrDisplayed = (question is MultipleChoiceQuestion && question.selectedAnswer != null) ||
        (question is DescriptionQuestion && question.isDisplay);
    final color = isSelected
        ? Colors.blue
        : isAnsweredOrDisplayed
            ? Colors.green
            : Colors.grey;
    return GestureDetector(
      onTap: () {
        context.read<QuestionsBloc>().add(QuestionsMovieToQuestionEvent(question));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
        child: Center(
          child: Text(
            '${index + 1}',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildChoices(BuildContext context) {
    return BlocBuilder<QuestionsBloc, QuestionsState>(
      builder: (context, state) {
        if (state is QuestionsLoaded) {
          final question = state.currentQuestion;
          if (question is MultipleChoiceQuestion) {
            return _buildMultipleChoiceChoices(context, question);
          }
          if (question is PuzzleTextQuestion) {
            return _buildPuzzleTextChoices(context, question);
          }
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildMultipleChoiceChoices(BuildContext context, MultipleChoiceQuestion question) {
    return Column(
      children: [
        const Divider(),
        Column(
          children: List.generate(
            growable: true,
            question.answers.length,
            (index) {
              final choice = question.answers[index];
              final isSelected = question.selectedAnswer == choice;

              final isSubmitted = question.isSubmitted;

              final color = isSelected
                  ? isSubmitted
                      ? question.isCorrect == true
                          ? Colors.green
                          : Colors.red
                      : Colors.blue
                  : Colors.grey;

              return GestureDetector(
                onTap: isSubmitted ? null : () => _onChoiceSelected(context, isSelected, choice),
                child: Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    choice.text,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),
                  ),
                ),
              );
            },
          ),
        ),
        question.isSubmitted
            ? question.isCorrect == true
                ? const Text('Correct!', style: TextStyle(color: Colors.green))
                : const Text('Incorrect!', style: TextStyle(color: Colors.red))
            : const SizedBox.shrink(),
        question.isSubmitted && question.isCorrect == true
            ? const SizedBox.shrink()
            : Column(
                children: [
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: BasicButton.primary(
                      width: double.infinity,
                      text: question.isSubmitted ? 'retry' : 'Submit',
                      onPressed:
                          question.selectedAnswer != null ? () => _onSubmit(context, question.isSubmitted) : null,
                    ),
                  ),
                ],
              ),
      ],
    );
  }

  void _onChoiceSelected(BuildContext context, bool isSelected, Answer choice) {
    if (isSelected) {
      context.read<QuestionsBloc>().add(QuestionsUnselectAnswerEvent());
    } else {
      context.read<QuestionsBloc>().add(QuestionsSelectAnswerEvent(choice));
    }
  }

  void _onSubmit(BuildContext context, bool isSubmitted) {
    if (isSubmitted) {
      context.read<QuestionsBloc>().add(QuestionsResetEvent());
    } else {
      context.read<QuestionsBloc>().add(QuestionsSubmitEvent());
    }
  }

  Widget _buildPuzzleTextChoices(BuildContext context, PuzzleTextQuestion question) {
    final questionPlaces = question.places.where((element) => element.choice != null).toList();
    return Column(
      children: [
        questionPlaces.isNotEmpty
            ? Column(
                children: [
                  const Divider(),
                  ListViewHorizontal(
                    itemCount: questionPlaces.length,
                    itemBuilder: (BuildContext context, int index) {
                      final place = questionPlaces[index];
                      return GestureDetector(
                        onTap: () => context.read<QuestionsBloc>().add(QuestionsRemovePuzzleTextAnswerEvent(place)),
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            place.choice?.name ?? "",
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              )
            : const SizedBox.shrink(),
        const Divider(),
        Column(
          children: List.generate(
            question.choices.length,
            (index) {
              final choice = question.choices[index];

              final isSubmitted = question.isSubmitted;

              return GestureDetector(
                onTap: isSubmitted ? null : () => _onPuzzleTextChoiceSelected(context, choice),
                child: Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    choice.name,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  _onPuzzleTextChoiceSelected(BuildContext context, QuestionDataChoice choice) {
    context.read<QuestionsBloc>().add(QuestionsSelectPuzzleTextAnswerEvent(choice: choice));
  }
}
