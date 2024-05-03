// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bahaso_mobile_app/core/common/constants.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';

import 'models.dart';

sealed class Question extends Equatable {
  final List<QuestionDisplay> questionDisplays;

  const Question({required this.questionDisplays});

  @override
  List<Object?> get props => [questionDisplays];
}

class DescriptionQuestion extends Question {
  final String questionNumber;
  final bool isDisplay;
  const DescriptionQuestion({
    required super.questionDisplays,
    required this.questionNumber,
    this.isDisplay = false,
  });

  DescriptionQuestion selectToDisplay() {
    return DescriptionQuestion(
      questionDisplays: questionDisplays,
      questionNumber: questionNumber,
      isDisplay: true,
    );
  }

  @override
  List<Object?> get props => [questionDisplays, questionNumber, isDisplay];

  @override
  bool get stringify => true;
}

class MultipleChoiceQuestion extends Question {
  final int questionNumber;
  final List<QuestionDataText> data;
  final String correctAnswer;
  final QuestionDataText? selectedData;
  final bool? isCorrect;
  final bool isSubmitted;
  const MultipleChoiceQuestion({
    required super.questionDisplays,
    required this.questionNumber,
    required this.correctAnswer,
    required this.data,
    this.isCorrect,
    this.selectedData,
    this.isSubmitted = false,
  });

  bool isAnswered() => selectedData != null;

  MultipleChoiceQuestion selectAnswer(QuestionDataText selectedData) {
    return MultipleChoiceQuestion(
      questionDisplays: questionDisplays,
      questionNumber: questionNumber,
      correctAnswer: correctAnswer,
      data: data,
      selectedData: selectedData,
      isCorrect: isCorrect,
      isSubmitted: isSubmitted,
    );
  }

  MultipleChoiceQuestion unselectAnswer() {
    return MultipleChoiceQuestion(
      questionDisplays: questionDisplays,
      questionNumber: questionNumber,
      correctAnswer: correctAnswer,
      data: data,
      selectedData: null,
      isCorrect: isCorrect,
      isSubmitted: isSubmitted,
    );
  }

  MultipleChoiceQuestion submit() {
    if (selectedData == null) {
      return this;
    }
    final isAnswerCorrect = selectedData?.value == correctAnswer;
    return MultipleChoiceQuestion(
      questionDisplays: questionDisplays,
      questionNumber: questionNumber,
      correctAnswer: correctAnswer,
      data: data,
      selectedData: selectedData,
      isCorrect: isAnswerCorrect,
      isSubmitted: true,
    );
  }

  MultipleChoiceQuestion reset() {
    return MultipleChoiceQuestion(
      questionDisplays: questionDisplays,
      questionNumber: questionNumber,
      correctAnswer: correctAnswer,
      data: data,
      selectedData: null,
      isCorrect: null,
      isSubmitted: false,
    );
  }

  @override
  List<Object?> get props => [
        questionDisplays,
        questionNumber,
        correctAnswer,
        data,
        selectedData,
        isCorrect,
        isSubmitted,
      ];

  @override
  bool get stringify => true;
}

class PuzzleTextQuestion extends Question {
  final bool? isCorrect;
  final bool isSubmitted;
  final int questionNumber;
  final List<QuestionData> data;
  const PuzzleTextQuestion({
    this.isCorrect,
    required this.questionNumber,
    this.isSubmitted = false,
    this.data = const [],
    required super.questionDisplays,
  });

  @override
  List<Object?> get props => [questionDisplays, isCorrect, isSubmitted, data, questionNumber];

  List<QuestionDataPlace> get places => data.whereType<QuestionDataPlace>().toList();

  List<QuestionDataImage> get images => data.whereType<QuestionDataImage>().toList();

  List<QuestionDataChoice> get choices => data.whereType<QuestionDataChoice>().toList();

  PuzzleTextQuestion selectAnswer(QuestionDataChoice choice, QuestionDataPlace? place) {
    QuestionDataPlace? updated;
    if (place != null) {
      updated = place.copyWith(choice: choice);
    } else {
      updated = places.firstWhereOrNull((element) => element.choice == null)?.copyWith(choice: choice);
    }

    final newData = data.map((e) {
      if (e is QuestionDataPlace && updated != null && e.name == updated.name) {
        return updated;
      }
      return e;
    }).toList();

    return PuzzleTextQuestion(
      isCorrect: isCorrect,
      isSubmitted: isSubmitted,
      questionNumber: questionNumber,
      data: newData,
      questionDisplays: questionDisplays,
    );
  }

  PuzzleTextQuestion removeAnswer(QuestionDataPlace place) {
    final newData = data.map((e) {
      if (e is QuestionDataPlace && e.name == place.name) {
        return QuestionDataPlace(name: e.name, choice: null);
      }
      return e;
    }).toList();

    return PuzzleTextQuestion(
      isCorrect: isCorrect,
      isSubmitted: isSubmitted,
      questionNumber: questionNumber,
      data: newData,
      questionDisplays: questionDisplays,
    );
  }

  bool isAnswered() {
    return data.every((element) {
      if (element is QuestionDataPlace) {
        return element.choice != null;
      }
      return true;
    });
  }

  @override
  bool get stringify => true;
}

class TrueFalseQuestion extends Question {
  final QuestionDataTrueFalse? selectedData;
  final String correctAnswer;
  final bool? isCorrect;
  final bool isSubmitted;
  final int questionNumber;
  final List<QuestionDataTrueFalse> data;
  const TrueFalseQuestion({
    required super.questionDisplays,
    this.selectedData,
    this.isCorrect,
    this.isSubmitted = false,
    required this.questionNumber,
    required this.data,
    required this.correctAnswer,
  });

  bool isAnswered() => selectedData != null;

  TrueFalseQuestion selectAnswer(QuestionDataTrueFalse selectedData) {
    return TrueFalseQuestion(
      questionDisplays: questionDisplays,
      questionNumber: questionNumber,
      correctAnswer: correctAnswer,
      data: data,
      selectedData: selectedData,
      isCorrect: isCorrect,
      isSubmitted: isSubmitted,
    );
  }

  TrueFalseQuestion submit() {
    if (selectedData == null) {
      return this;
    }
    final isAnswerCorrect = selectedData?.value == correctAnswer;
    return TrueFalseQuestion(
      questionDisplays: questionDisplays,
      questionNumber: questionNumber,
      correctAnswer: correctAnswer,
      data: data,
      selectedData: selectedData,
      isCorrect: isAnswerCorrect,
      isSubmitted: true,
    );
  }

  TrueFalseQuestion reset() {
    return TrueFalseQuestion(
      questionDisplays: questionDisplays,
      questionNumber: questionNumber,
      correctAnswer: correctAnswer,
      data: data,
      selectedData: null,
      isCorrect: null,
      isSubmitted: false,
    );
  }

  @override
  List<Object?> get props => [
        questionDisplays,
        selectedData,
        isCorrect,
        isSubmitted,
        questionNumber,
        data,
        correctAnswer,
      ];

  @override
  bool get stringify => true;
}

class MatchQuestion extends Question {
  final Map<QuestionDataText, String> selectedData;
  final List<QuestionData> data;
  final int questionNumber;
  const MatchQuestion({
    required super.questionDisplays,
    this.selectedData = const {},
    required this.questionNumber,
    this.data = const [],
  });

  List<QuestionDataText> get choices => data.whereType<QuestionDataText>().toList();

  QuestionDataOptions? get options =>
      data.firstWhereOrNull((element) => element is QuestionDataOptions) as QuestionDataOptions?;

  @override
  List<Object?> get props => [questionDisplays, selectedData, questionNumber];

  MatchQuestion selectAnswer(String place) {
    final updated = Map<QuestionDataText, String>.from(selectedData);
    logger.d("selectedData:MatchQuestion $selectedData");
    QuestionDataText? choice = choices.firstWhereOrNull((element) => updated[element] == null);

    if (choice != null) {
      if (!updated.containsKey(choice)) {
        updated.addAll({choice: place});
      } else {
        updated.update(choice, (value) => place);
      }
    }

    return MatchQuestion(
      questionDisplays: questionDisplays,
      questionNumber: questionNumber,
      selectedData: updated,
      data: data,
    );
  }

  MatchQuestion removeAnswer(QuestionDataText choice) {
    final updated = Map<QuestionDataText, String>.from(selectedData);
    updated.remove(choice);

    return MatchQuestion(
      questionDisplays: questionDisplays,
      questionNumber: questionNumber,
      selectedData: updated,
      data: data,
    );
  }

  bool isAnswered() {
    return selectedData.length == questionDisplays.length;
  }

  @override
  bool get stringify => true;
}
