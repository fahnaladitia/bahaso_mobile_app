import 'package:bahaso_mobile_app/domain/models/models.dart';

extension QuestionExt on Question {
  Question applyToDisplay() {
    switch (runtimeType) {
      case DescriptionQuestion:
        final updatedQuestion = this as DescriptionQuestion;
        return updatedQuestion.copyWith(isDisplay: true);
      case PuzzleTextQuestion:
        final updatedQuestion = this as PuzzleTextQuestion;
        return updatedQuestion.copyWith(isDisplay: true);
      case MultipleChoiceQuestion:
        final updatedQuestion = this as MultipleChoiceQuestion;
        return updatedQuestion.copyWith(isDisplay: true);
      case TrueFalseQuestion:
        final updatedQuestion = this as TrueFalseQuestion;
        return updatedQuestion.copyWith(isDisplay: true);
      case MatchQuestion:
        final updatedQuestion = this as MatchQuestion;
        return updatedQuestion.copyWith(isDisplay: true);

      default:
        return this;
    }
  }
}
