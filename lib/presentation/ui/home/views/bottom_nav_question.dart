import 'package:bahaso_mobile_app/core/common/constants.dart';
import 'package:bahaso_mobile_app/domain/models/models.dart';
import 'package:bahaso_mobile_app/presentation/components/components.dart';
import 'package:bahaso_mobile_app/presentation/ui/home/bloc/questions_bloc.dart';
import 'package:collection/collection.dart';
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
    final isAnsweredOrDisplayed = (question is MultipleChoiceQuestion && question.selectedData != null) ||
        (question is DescriptionQuestion && question.isDisplay) ||
        (question is TrueFalseQuestion && question.isCorrect != null);
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
            _getQuestionIndicatorText(question),
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
          if (question is TrueFalseQuestion) {
            return _buildTrueFalseChoices(context, question);
          }
          if (question is MatchQuestion) {
            return _buildMatchChoices(context, question);
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
            question.data.length,
            (index) {
              final choice = question.data[index];
              final isSelected = question.selectedData == choice;

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
                      onPressed: question.selectedData != null ? () => _onSubmit(context, question.isSubmitted) : null,
                    ),
                  ),
                ],
              ),
      ],
    );
  }

  void _onChoiceSelected(BuildContext context, bool isSelected, QuestionDataText? choice) {
    if (isSelected) {
      context.read<QuestionsBloc>().add(QuestionsUnselectAnswerEvent(choice));
    } else {
      if (choice == null) return;
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

  String _getQuestionIndicatorText(Question question) {
    switch (question.runtimeType) {
      case MultipleChoiceQuestion:
        final multipleChoiceQuestion = question as MultipleChoiceQuestion;
        return multipleChoiceQuestion.questionNumber.toString();
      case DescriptionQuestion:
        final descriptionQuestion = question as DescriptionQuestion;
        return descriptionQuestion.questionNumber;
      case PuzzleTextQuestion:
        final puzzleTextQuestion = question as PuzzleTextQuestion;
        return puzzleTextQuestion.questionNumber.toString();
      case TrueFalseQuestion:
        final trueFalseQuestion = question as TrueFalseQuestion;
        return trueFalseQuestion.questionNumber.toString();
      case MatchQuestion:
        final matchQuestion = question as MatchQuestion;
        return matchQuestion.questionNumber.toString();
      default:
        return '';
    }
  }

  Widget _buildTrueFalseChoices(BuildContext context, TrueFalseQuestion question) {
    return Column(
      children: [
        const Divider(),
        Column(
          children: List.generate(
            question.data.length,
            (index) {
              final choice = question.data[index];
              final isSelected = question.selectedData == choice;

              final isSubmitted = question.isSubmitted;

              final color = isSelected
                  ? isSubmitted
                      ? question.isCorrect == true
                          ? Colors.green
                          : Colors.red
                      : Colors.blue
                  : Colors.grey;

              return GestureDetector(
                onTap: isSubmitted ? null : () => _onTrueFalseChoiceSelected(context, choice),
                child: Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Icon(
                      choice.status ? Icons.check : Icons.close,
                      color: Colors.white,
                    ),
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
                      onPressed: question.selectedData != null ? () => _onSubmit(context, question.isSubmitted) : null,
                    ),
                  ),
                ],
              ),
      ],
    );
  }

  _onTrueFalseChoiceSelected(BuildContext context, QuestionDataTrueFalse choice) {
    context.read<QuestionsBloc>().add(QuestionsSelectAnswerEvent(choice));
  }

  Widget _buildMatchChoices(BuildContext context, MatchQuestion question) {
    final options = question.options;
    return Column(
      children: [
        const Divider(),
        Column(
          children: List.generate(
            options?.choices.length ?? 0,
            (index) {
              final choice = options?.choices[index] ?? "";
              final isSelected = question.selectedData.containsValue(choice);
              final dataTextEntry = question.selectedData
                  .map((key, value) => MapEntry(value, key))
                  .entries
                  .firstWhereOrNull((element) => element.key == choice);
              final dataText = dataTextEntry?.value;

              final color = isSelected ? Colors.blue : Colors.grey;

              return GestureDetector(
                onTap: () => _onMatchChoiceSelected(context, dataText, choice, isSelected: isSelected),
                child: Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    choice,
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

  _onMatchChoiceSelected(BuildContext context, QuestionDataText? dataText, String choice, {bool isSelected = false}) {
    if (isSelected) {
      context.read<QuestionsBloc>().add(QuestionsUnselectAnswerEvent(dataText));
    } else {
      context.read<QuestionsBloc>().add(QuestionsSelectMatchAnswerEvent(choice));
    }
  }
}
