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
    data: [
      QuestionDataText(name: "q13766:8_answer", value: "0", text: "Her name is Briana."),
      QuestionDataText(name: "q13766:8_answer", value: "1", text: "Her name is Jack."),
      QuestionDataText(name: "q13766:8_answer", value: "2", text: "Her name is Diana."),
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
    data: [
      QuestionDataText(name: "q13766:12_answer", value: "0", text: "Her name is Susilo."),
      QuestionDataText(name: "q13766:12_answer", value: "1", text: "His name is Susilo."),
      QuestionDataText(name: "q13766:12_answer", value: "2", text: "She is Susilo."),
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
  TrueFalseQuestion(
    questionNumber: 9,
    correctAnswer: "1",
    questionDisplays: [
      TextQuestionDisplay(question: "Tentukan benar atau salah berdasarkan gambar berikut ini"),
      ImageQuestionDisplay(
        question:
            "https://learning.test.bahaso.com/getpluginfile.php/18/question/questiontext/13766/14/67325/Soekarno.png?time=1692342404137",
      ),
      TextQuestionDisplay(question: "Her name is Soekarno."),
      TextQuestionDisplay(question: "Apakah pernyataan ini benar?"),
    ],
    data: [
      QuestionDataTrueFalse(name: "q13766:14_answer", value: "1", status: true),
      QuestionDataTrueFalse(name: "q13766:14_answer", value: "0", status: false),
    ],
  ),
  DescriptionQuestion(
    questionNumber: "i.4",
    questionDisplays: [
      TextQuestionDisplay(question: "Perhatikan percakapan berikut ini"),
      ImageQuestionDisplay(
        question:
            "https://learning.test.bahaso.com/getpluginfile.php/18/question/questiontext/13766/16/67330/Ben%20nunjuk%20Karen.jpg?time=1692342557585",
      ),
      AudioQuestionDisplay(
          question:
              "https://learning.test.bahaso.com/getpluginfile.php/18/question/questiontext/13766/16/67330/This%20is%20my%20friend%20%28conversation%29.mp3?time=1692342640330"),
      TextQuestionDisplay(question: "Ben : This is my friend. Her name is Karen."),
    ],
  ),
  MatchQuestion(
    questionNumber: 10,
    questionDisplays: [
      TextQuestionDisplay(question: "Pilih verb be yang tepat untuk kalimat di bawah ini"),
    ],
    data: [
      QuestionDataOptions(["Choose...", "are", "am", "is"]),
      QuestionDataText(text: "Their names ___ Brandon and Billy.", name: "q13766:27_sub0", value: "0"),
      QuestionDataText(text: "They ___ Sonny, Doni, and Tina.", name: "q13766:27_sub1", value: "0"),
      QuestionDataText(text: "I ___ John.", name: "q13766:27_sub2", value: "0"),
      QuestionDataText(text: "He ___ Toni.", name: "q13766:27_sub3", value: "0"),
    ],
  )
];

// "datatext": [
//           {
//             "text": "Their names ___ Brandon and Billy.",
//             "name": "q13766:27_sub0",
//             "value": 0
//           },
//           {
//             "text": "They ___ Sonny, Doni, and Tina.",
//             "name": "q13766:27_sub1",
//             "value": 0
//           },
//           {
//             "text": "I ___ John.",
//             "name": "q13766:27_sub2",
//             "value": 0
//           },
//           {
//             "text": "He ___ Toni.",
//             "name": "q13766:27_sub3",
//             "value": 0
//           }
//         ]

// {
//       "question": [
//         "Tentukan benar atau salah berdasarkan gambarberikut ini",
//         "https://learning.test.bahaso.com/getpluginfile.php/18/question/questiontext/13766/14/67325/Soekarno.png?time=1692342404137",
//         "Her name is Soekarno.",
//         "Apakah pernyataan ini benar?"
//       ],
//       "questionnumber": 6,
//       "typequestion": "truefalse",
//       "name": "q13766:14_:sequencecheck",
//       "value": "1",
//       "grade": 1,
//       "data": [
//         {
//           "text": "True",
//           "name": "q13766:14_answer",
//           "value": "1"
//         },
//         {
//           "text": "False",
//           "name": "q13766:14_answer",
//           "value": "0"
//         }
//       ]
//     },