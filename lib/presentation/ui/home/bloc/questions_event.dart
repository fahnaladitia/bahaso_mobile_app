part of 'questions_bloc.dart';

sealed class QuestionsEvent extends Equatable {
  const QuestionsEvent();

  @override
  List<Object> get props => [];
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
  final Answer answer;

  const QuestionsSelectAnswerEvent(this.answer);

  @override
  List<Object> get props => [answer];

  @override
  bool get stringify => true;
}

final class QuestionsUnselectAnswerEvent extends QuestionsEvent {}

final class QuestionsSubmitEvent extends QuestionsEvent {}

final class QuestionsResetEvent extends QuestionsEvent {}
