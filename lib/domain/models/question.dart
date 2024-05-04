// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';

import 'package:bahaso_mobile_app/core/common/constants.dart';

import 'models.dart';

sealed class Question extends Equatable {
  final List<QuestionDisplay> questionDisplays;
  final bool isDisplay;

  const Question({required this.questionDisplays, this.isDisplay = false});

  @override
  List<Object?> get props => [questionDisplays, isDisplay];
}

class DescriptionQuestion extends Question {
  final String questionNumber;
  const DescriptionQuestion({
    required super.questionDisplays,
    required this.questionNumber,
    super.isDisplay,
  });

  @override
  List<Object?> get props => [questionDisplays, questionNumber, isDisplay];

  @override
  bool get stringify => true;

  DescriptionQuestion copyWith({
    String? questionNumber,
    bool? isDisplay,
  }) {
    return DescriptionQuestion(
      questionNumber: questionNumber ?? this.questionNumber,
      questionDisplays: questionDisplays,
      isDisplay: isDisplay ?? this.isDisplay,
    );
  }
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
    super.isDisplay,
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
      isDisplay: isDisplay,
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
      isDisplay: isDisplay,
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
      isDisplay: isDisplay,
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
      isDisplay: isDisplay,
    );
  }

  String get buttonSubmitText {
    if (isSubmitted) {
      return isCorrect == true ? 'Correct' : 'Retry';
    }
    return 'Submit';
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
        isDisplay,
      ];

  @override
  bool get stringify => true;

  MultipleChoiceQuestion copyWith({
    int? questionNumber,
    List<QuestionDataText>? data,
    String? correctAnswer,
    QuestionDataText? selectedData,
    bool? isCorrect,
    bool? isSubmitted,
    bool? isDisplay,
  }) {
    return MultipleChoiceQuestion(
      questionNumber: questionNumber ?? this.questionNumber,
      data: data ?? this.data,
      correctAnswer: correctAnswer ?? this.correctAnswer,
      selectedData: selectedData ?? this.selectedData,
      isCorrect: isCorrect ?? this.isCorrect,
      isSubmitted: isSubmitted ?? this.isSubmitted,
      isDisplay: isDisplay ?? this.isDisplay,
      questionDisplays: questionDisplays,
    );
  }
}

class PuzzleTextQuestion extends Question {
  final int questionNumber;
  final List<QuestionData> data;
  const PuzzleTextQuestion({
    required this.questionNumber,
    this.data = const [],
    required super.questionDisplays,
    super.isDisplay,
  });

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
      questionNumber: questionNumber,
      data: newData,
      questionDisplays: questionDisplays,
      isDisplay: isDisplay,
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
      questionNumber: questionNumber,
      data: newData,
      questionDisplays: questionDisplays,
      isDisplay: isDisplay,
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
  List<Object?> get props => [
        questionDisplays,
        data,
        questionNumber,
        isDisplay,
      ];

  @override
  bool get stringify => true;

  PuzzleTextQuestion copyWith({
    int? questionNumber,
    List<QuestionData>? data,
    bool? isDisplay,
  }) {
    return PuzzleTextQuestion(
      questionNumber: questionNumber ?? this.questionNumber,
      data: data ?? this.data,
      questionDisplays: questionDisplays,
      isDisplay: isDisplay ?? this.isDisplay,
    );
  }
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
    super.isDisplay,
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
      isDisplay: isDisplay,
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
      isDisplay: isDisplay,
    );
  }

  bool get isSubmittedAndCorrect {
    return isSubmitted && isCorrect == true;
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
      isDisplay: isDisplay,
    );
  }

  String get buttonSubmitText {
    if (isSubmitted) {
      return isCorrect == true ? 'Correct' : 'Retry';
    }
    return 'Submit';
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
        isDisplay,
      ];

  @override
  bool get stringify => true;

  TrueFalseQuestion copyWith({
    QuestionDataTrueFalse? selectedData,
    String? correctAnswer,
    bool? isCorrect,
    bool? isSubmitted,
    int? questionNumber,
    List<QuestionDataTrueFalse>? data,
    bool? isDisplay,
  }) {
    return TrueFalseQuestion(
      selectedData: selectedData ?? this.selectedData,
      correctAnswer: correctAnswer ?? this.correctAnswer,
      isCorrect: isCorrect ?? this.isCorrect,
      isSubmitted: isSubmitted ?? this.isSubmitted,
      questionNumber: questionNumber ?? this.questionNumber,
      data: data ?? this.data,
      questionDisplays: questionDisplays,
      isDisplay: isDisplay ?? this.isDisplay,
    );
  }
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
    super.isDisplay,
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
      isDisplay: isDisplay,
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
      isDisplay: isDisplay,
    );
  }

  bool isAnswered() {
    return selectedData.length == questionDisplays.length;
  }

  QuestionDataText? getSelectedChoice(String place) {
    return selectedData.entries.firstWhereOrNull((element) => element.value == place)?.key;
  }

  @override
  bool get stringify => true;

  MatchQuestion copyWith({
    Map<QuestionDataText, String>? selectedData,
    List<QuestionData>? data,
    int? questionNumber,
    bool? isDisplay,
  }) {
    return MatchQuestion(
      selectedData: selectedData ?? this.selectedData,
      data: data ?? this.data,
      questionNumber: questionNumber ?? this.questionNumber,
      questionDisplays: questionDisplays,
      isDisplay: isDisplay ?? this.isDisplay,
    );
  }
}
