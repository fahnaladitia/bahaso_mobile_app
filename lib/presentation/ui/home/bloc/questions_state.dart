part of 'questions_bloc.dart';

sealed class QuestionsState extends Equatable {
  const QuestionsState();

  @override
  List<Object> get props => [];
}

final class QuestionsInitial extends QuestionsState {}

final class QuestionsLoading extends QuestionsState {}

final class QuestionsLoaded extends QuestionsState {
  final List<Question> questions;
  final Question currentQuestion;
  final int currentQuestionIndex;

  const QuestionsLoaded(this.questions, this.currentQuestion, this.currentQuestionIndex);

  @override
  List<Object> get props => [questions, currentQuestion];

  @override
  bool get stringify => true;
}

final class QuestionsError extends QuestionsState {
  final String message;

  const QuestionsError(this.message);

  @override
  List<Object> get props => [message];

  @override
  bool get stringify => true;
}

final class QuestionsEmpty extends QuestionsState {}
