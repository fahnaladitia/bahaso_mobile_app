part of 'questions_bloc.dart';

sealed class QuestionsEvent extends Equatable {
  const QuestionsEvent();

  @override
  List<Object?> get props => [];
}

final class QuestionsFetchEvent extends QuestionsEvent {}

final class QuestionsNextEvent extends QuestionsEvent {}

final class QuestionsPreviousEvent extends QuestionsEvent {}

final class QuestionsMovieToQuestionEvent extends QuestionsEvent {
  final Question question;

  const QuestionsMovieToQuestionEvent(this.question);

  @override
  List<Object> get props => [question];

  @override
  bool get stringify => true;
}

final class QuestionsSelectAnswerEvent extends QuestionsEvent {
  final QuestionData selectedData;
  final String? selectedOption;

  const QuestionsSelectAnswerEvent(this.selectedData, {this.selectedOption});

  @override
  List<Object?> get props => [selectedData, selectedOption];

  @override
  bool get stringify => true;
}

final class QuestionsUnselectAnswerEvent extends QuestionsEvent {
  final QuestionDataText? selectedData;

  const QuestionsUnselectAnswerEvent([this.selectedData]);

  @override
  List<Object?> get props => [selectedData];

  @override
  bool get stringify => true;
}

final class QuestionsSubmitEvent extends QuestionsEvent {}

final class QuestionsResetEvent extends QuestionsEvent {}

final class QuestionsSelectPuzzleTextAnswerEvent extends QuestionsEvent {
  final QuestionDataChoice choice;
  final QuestionDataPlace? place;

  const QuestionsSelectPuzzleTextAnswerEvent({this.place, required this.choice});

  @override
  List<Object?> get props => [choice, place];

  @override
  bool get stringify => true;
}

final class QuestionsRemovePuzzleTextAnswerEvent extends QuestionsEvent {
  final QuestionDataPlace place;

  const QuestionsRemovePuzzleTextAnswerEvent(this.place);

  @override
  List<Object?> get props => [place];

  @override
  bool get stringify => true;
}

final class QuestionsSelectMatchAnswerEvent extends QuestionsEvent {
  final String choice;

  const QuestionsSelectMatchAnswerEvent(this.choice);

  @override
  List<Object?> get props => [choice];

  @override
  bool get stringify => true;
}
