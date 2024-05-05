import 'package:bahaso_mobile_app/domain/models/models.dart';
import 'package:collection/collection.dart';

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

  bool isCompleted() {
    switch (runtimeType) {
      case MultipleChoiceQuestion:
        final multipleChoiceQuestion = this as MultipleChoiceQuestion;
        return multipleChoiceQuestion.isAnswered() && multipleChoiceQuestion.isCorrect == true;
      case TrueFalseQuestion:
        final trueFalseQuestion = this as TrueFalseQuestion;
        return trueFalseQuestion.isAnswered() && trueFalseQuestion.isCorrect == true;
      case DescriptionQuestion:
      case PuzzleTextQuestion:
      case MatchQuestion:
        return isDisplay;
      default:
        return true;
    }
  }
}

extension QuestionsExt on List<Question> {
  bool isLastQuestionWithQuestion(Question question) {
    return indexOf(question) == length - 1;
  }

  bool isLastQuestionWithIndex(int index) {
    return index == length - 1;
  }

  bool isFirstQuestionWithQuestion(Question question) {
    return indexOf(question) == 0;
  }

  bool isFirstQuestionWithIndex(int index) {
    return index == 0;
  }

  bool isAllBeforeTargetQuestionIsCompleted(Question target) {
    final targetIndex = indexOf(target);
    bool isAllBeforeTargetQuestionIsCompleted = true;
    for (var i = 0; i < targetIndex; i++) {
      final question = this[i];

      final isCompleted = question.isCompleted();

      if (!isCompleted) {
        isAllBeforeTargetQuestionIsCompleted = false;
        break;
      }
    }
    return isAllBeforeTargetQuestionIsCompleted;
  }

  bool isAfterQuestion({required Question current, required Question target}) {
    final currentIndex = indexOf(current);
    final targetIndex = indexOf(target);
    final isAfterQuestion = targetIndex > currentIndex;
    return isAfterQuestion;
  }
}

extension PuzzleTextQuestionDisplayExt on PuzzleTextQuestionDisplay {
  QuestionDataImage? image(PuzzleTextQuestion question) {
    if (imageSlots.isEmpty) {
      return null;
    }

    List<QuestionDataImage> images = [];

    for (var i = 0; i < imageSlots.length; i++) {
      final imageSlot = imageSlots[i];
      final image = question.images.firstWhereOrNull((element) => element.slot == imageSlot);
      if (image != null) {
        images.add(image);
      }
    }

    return images.firstOrNull;
  }

  List<QuestionDataPlace> places(PuzzleTextQuestion question) {
    final List<QuestionDataPlace> places = [];

    for (var i = 0; i < placesIds.length; i++) {
      final placeId = placesIds[i];
      final place = question.places[placeId];
      places.add(place);
    }

    return places;
  }
}
