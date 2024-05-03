// ignore_for_file: public_member_api_docs, sort_constructors_first
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
  final List<TextAnswer> answers;
  final String correctAnswer;
  final TextAnswer? selectedAnswer;
  final bool? isCorrect;
  final bool isSubmitted;
  const MultipleChoiceQuestion({
    required super.questionDisplays,
    required this.questionNumber,
    required this.correctAnswer,
    required this.answers,
    this.isCorrect,
    this.selectedAnswer,
    this.isSubmitted = false,
  });

  bool isAnswerCorrect() => selectedAnswer?.value == correctAnswer;

  bool isAnswered() => selectedAnswer != null;

  MultipleChoiceQuestion selectAnswer(TextAnswer answer) {
    return MultipleChoiceQuestion(
      questionDisplays: questionDisplays,
      questionNumber: questionNumber,
      correctAnswer: correctAnswer,
      answers: answers,
      selectedAnswer: answer,
      isCorrect: isCorrect,
      isSubmitted: isSubmitted,
    );
  }

  MultipleChoiceQuestion unselectAnswer() {
    return MultipleChoiceQuestion(
      questionDisplays: questionDisplays,
      questionNumber: questionNumber,
      correctAnswer: correctAnswer,
      answers: answers,
      selectedAnswer: null,
      isCorrect: isCorrect,
      isSubmitted: isSubmitted,
    );
  }

  MultipleChoiceQuestion submit() {
    if (selectedAnswer == null) {
      return this;
    }
    final isAnswerCorrect = selectedAnswer?.value == correctAnswer;
    return MultipleChoiceQuestion(
      questionDisplays: questionDisplays,
      questionNumber: questionNumber,
      correctAnswer: correctAnswer,
      answers: answers,
      selectedAnswer: selectedAnswer,
      isCorrect: isAnswerCorrect,
      isSubmitted: true,
    );
  }

  MultipleChoiceQuestion reset() {
    return MultipleChoiceQuestion(
      questionDisplays: questionDisplays,
      questionNumber: questionNumber,
      correctAnswer: correctAnswer,
      answers: answers,
      selectedAnswer: null,
      isCorrect: null,
      isSubmitted: false,
    );
  }

  @override
  List<Object?> get props => [
        questionDisplays,
        questionNumber,
        correctAnswer,
        answers,
        selectedAnswer,
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

const dummyQuestions = [
  DescriptionQuestion(questionNumber: "i.1", questionDisplays: [
    TextQuestionDisplay(question: "Perhatikan percakapan dalam video berikut ini"),
    VideoQuestionDisplay(
      question:
          "https://learning.test.bahaso.com/getpluginfile.php/18/question/questiontext/13766/1/67289/rev%201%20Hello%20I%20am%20Karen%20my%20name%20is%20Karen.mp4",
    ),
    TextQuestionDisplay(question: "Karen: Hello! I am Karen. My name is Karen."),
    TextQuestionDisplay(question: "Karen: Halo nama saya Karen. Senang bertemu kalian semua."),
    TextQuestionDisplay(question: "Karen: He is Kevin. His name is Kevin."),
    TextQuestionDisplay(question: "Karen: Dia adalah Kevin. Nama dia adalah Kevin."),
    TextQuestionDisplay(question: "Karen: She is Daisy. Her name is Daisy."),
    TextQuestionDisplay(question: "Karen: Dia adalah Daisy. Nama dia adalah Daisy."),
    TextQuestionDisplay(question: "Karen: What is your name?"),
    TextQuestionDisplay(question: "Karen: Siapa nama kamu?"),
  ]),
  DescriptionQuestion(questionNumber: "i.2", questionDisplays: [
    TextQuestionDisplay(question: "Klik audio dan pelajari cara pengucapannya"),
    ImageQuestionDisplay(
      question:
          "https://learning.test.bahaso.com/getpluginfile.php/18/question/questiontext/13766/2/67291/1%20Karen%20melambaikan%20tangan.png",
    ),
    AudioQuestionDisplay(
      question:
          "https://learning.test.bahaso.com/getpluginfile.php/18/question/questiontext/13766/2/67291/1%20Hello%20%28Karen%20melambaikan%20tangan%29.mp3",
    ),
    TextQuestionDisplay(question: "Hello!"),
    TextQuestionDisplay(question: "Halo"),
    ImageQuestionDisplay(
      question:
          "https://learning.test.bahaso.com/getpluginfile.php/18/question/questiontext/13766/2/67291/2%20Karen%20menunjuk%20dirinya%20sendiri.png",
    ),
    AudioQuestionDisplay(
      question:
          "https://learning.test.bahaso.com/getpluginfile.php/18/question/questiontext/13766/2/67291/2%20My%20name%20is%20Karen%20%28Karen%20menunjuk%20dirinya%20sendiri%29.mp3",
    ),
    TextQuestionDisplay(question: "My name is Karen."),
    TextQuestionDisplay(question: "Nama saya adalah Karen."),
    ImageQuestionDisplay(
      question:
          "https://learning.test.bahaso.com/getpluginfile.php/18/question/questiontext/13766/2/67291/3%20Karen%20menunjuk%20Kevin.png",
    ),
    AudioQuestionDisplay(
      question:
          "https://learning.test.bahaso.com/getpluginfile.php/18/question/questiontext/13766/2/67291/3%20His%20name%20is%20Kevin%20%28Karen%20menunjuk%20Kevin%29.mp3",
    ),
    TextQuestionDisplay(question: "His name is Kevin."),
    TextQuestionDisplay(question: "Nama dia adalah Kevin."),
    ImageQuestionDisplay(
      question:
          "https://learning.test.bahaso.com/getpluginfile.php/18/question/questiontext/13766/2/67291/4%20Karen%20menunjuk%20Daisy.png",
    ),
    AudioQuestionDisplay(
      question:
          "https://learning.test.bahaso.com/getpluginfile.php/18/question/questiontext/13766/2/67291/4%20Her%20name%20is%20Daisy%20%28Karen%20menunjuk%20Daisy%29.mp3",
    ),
    TextQuestionDisplay(question: "Her name is Daisy"),
    TextQuestionDisplay(question: "Nama dia adalah Daisy."),
    ImageQuestionDisplay(
      question:
          "https://learning.test.bahaso.com/getpluginfile.php/18/question/questiontext/13766/2/67291/5%20Karen%20membungkuk%20sopan.png",
    ),
    AudioQuestionDisplay(
      question:
          "https://learning.test.bahaso.com/getpluginfile.php/18/question/questiontext/13766/2/67291/5%20Nice%20to%20meet%20you%20%28Karen%20membungkuk%20sopan%29.mp3",
    ),
    TextQuestionDisplay(question: "Nice to meet you."),
    TextQuestionDisplay(question: "Senang bertemu denganmu."),
  ]),
  MultipleChoiceQuestion(
    questionNumber: 3,
    questionDisplays: [
      TextQuestionDisplay(question: "Dengarkan audio berikut dan pilih jawaban yang tepat"),
      AudioQuestionDisplay(
        question:
            "https://learning.test.bahaso.com/getpluginfile.php/18/question/questiontext/13766/8/67304/My%20name%20is%20Diana.mp3",
      ),
      TextQuestionDisplay(question: "What is her name?"),
    ],
    answers: [
      TextAnswer(text: "Her name is Briana.", value: "0", name: "q13766:8_answer"),
      TextAnswer(text: "Her name is Jack.", value: "1", name: "q13766:8_answer"),
      TextAnswer(text: "Her name is Diana.", value: "2", name: "q13766:8_answer"),
    ],
    correctAnswer: "1",
  ),
  MultipleChoiceQuestion(
    questionNumber: 4,
    questionDisplays: [
      TextQuestionDisplay(question: "Perhatikan gambar dan pilih jawaban yang tepat"),
      ImageQuestionDisplay(
        question: "https://learning.test.bahaso.com/getpluginfile.php/18/question/questiontext/13766/12/67316/SBY.png",
      ),
      TextQuestionDisplay(question: "Who is he?"),
    ],
    answers: [
      TextAnswer(text: "Her name is Susilo.", value: "0", name: "q13766:12_answer"),
      TextAnswer(text: "His name is Susilo.", value: "1", name: "q13766:12_answer"),
      TextAnswer(text: "She is Susilo.", value: "2", name: "q13766:12_answer"),
    ],
    correctAnswer: "1",
  ),
  PuzzleTextQuestion(
    questionNumber: 5,
    questionDisplays: [
      TextQuestionDisplay(question: "Pasangkan dengan kata yang tepat"),
      PuzzleTextQuestionDisplay(question: " blank", placesIds: [0], imageSlots: [0]),
      PuzzleTextQuestionDisplay(question: " blank", placesIds: [1], imageSlots: [1]),
      PuzzleTextQuestionDisplay(question: " blank", placesIds: [2], imageSlots: [2]),
      PuzzleTextQuestionDisplay(question: " blank", placesIds: [3], imageSlots: [3]),
    ],
    data: [
      QuestionDataImage(
        imageUrl:
            "https://learning.test.bahaso.com/getpluginfile.php/18/question/questiontext/13766/4/67295/1%20Karen%20melambaikan%20tangan.png",
        slot: 0,
      ),
      QuestionDataImage(
        imageUrl:
            "https://learning.test.bahaso.com/getpluginfile.php/18/question/questiontext/13766/4/67295/2%20Karen%20menunjuk%20dirinya%20sendiri.png",
        slot: 1,
      ),
      QuestionDataImage(
        imageUrl:
            "https://learning.test.bahaso.com/getpluginfile.php/18/question/questiontext/13766/4/67295/3%20Karen%20menunjuk%20Kevin.png",
        slot: 2,
      ),
      QuestionDataImage(
        imageUrl:
            "https://learning.test.bahaso.com/getpluginfile.php/18/question/questiontext/13766/4/67295/4%20Karen%20membungkuk%20sopan.png",
        slot: 3,
      ),
      QuestionDataPlace(name: "q13766:4_p1"),
      QuestionDataPlace(name: "q13766:4_p2"),
      QuestionDataPlace(name: "q13766:4_p3"),
      QuestionDataPlace(name: "q13766:4_p4"),
      QuestionDataChoice(name: "His name is Kevin.", value: 1),
      QuestionDataChoice(name: "My Name is Karen.", value: 2),
      QuestionDataChoice(name: "Nice to meet you!", value: 3),
      QuestionDataChoice(name: "Hello!", value: 4),
    ],
  ),
  PuzzleTextQuestion(
    questionNumber: 7,
    questionDisplays: [
      TextQuestionDisplay(question: "Pilih jawaban yang tepat"),
      PuzzleTextQuestionDisplay(question: "My name  blank Ben.", placesIds: [0]),
      PuzzleTextQuestionDisplay(question: "Her name  blank Daisy.", placesIds: [1]),
      PuzzleTextQuestionDisplay(question: "His name  blank Kevin.", placesIds: [2]),
      PuzzleTextQuestionDisplay(question: "Their names  blank Karen and Diana.", placesIds: [3]),
    ],
    data: [
      QuestionDataPlace(name: "q13766:22_p1"),
      QuestionDataPlace(name: "q13766:22_p2"),
      QuestionDataPlace(name: "q13766:22_p3"),
      QuestionDataPlace(name: "q13766:22_p4"),
      QuestionDataChoice(name: "are", value: 1),
      QuestionDataChoice(name: "is", value: 2),
    ],
  ),
  PuzzleTextQuestion(
    questionNumber: 8,
    questionDisplays: [
      TextQuestionDisplay(question: "Susun kata-kata di bawah ini menjadi kalimat yang benar"),
      PuzzleTextQuestionDisplay(question: " blank  blank  blank", placesIds: [0, 1, 2]),
    ],
    data: [
      QuestionDataPlace(name: "q13766:22_p1"),
      QuestionDataPlace(name: "q13766:22_p2"),
      QuestionDataPlace(name: "q13766:22_p3"),
      QuestionDataChoice(name: "Karen.", value: 1),
      QuestionDataChoice(name: "Her", value: 2),
      QuestionDataChoice(name: "name is", value: 3),
    ],
  ),
];


// {
//       "question": [
//         "Susun kata-kata di bawah ini menjadi kalimat yang benar",
//         " blank  blank  blank"
//       ],
//       "questionnumber": 4,
//       "typequestion": "ddwtos",
//       "name": "q13766:11_:sequencecheck",
//       "value": "1",
//       "grade": 1,
//       "data": {
//         "dataimage": [
          
//         ],
//         "dataplace": [
//           {
//             "name": "q13766:11_p1",
//             "value": "0"
//           },
//           {
//             "name": "q13766:11_p2",
//             "value": "0"
//           },
//           {
//             "name": "q13766:11_p3",
//             "value": "0"
//           }
//         ],
//         "datachoice": [
//           {
//             "name": "Karen.",
//             "value": 1
//           },
//           {
//             "name": "Her",
//             "value": 2
//           },
//           {
//             "name": "name is",
//             "value": 3
//           }
//         ]
//       }
//     },