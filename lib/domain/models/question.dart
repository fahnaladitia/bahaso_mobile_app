// ignore_for_file: public_member_api_docs, sort_constructors_first
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
  final List<Answer> answers;
  final String correctAnswer;
  final Answer? selectedAnswer;
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

  MultipleChoiceQuestion selectAnswer(Answer answer) {
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

const dummyQuestions = [
  DescriptionQuestion(questionNumber: "i.1", questionDisplays: [
    TextQuestion(question: "Perhatikan percakapan dalam video berikut ini"),
    VideoQuestion(
      question:
          "https://learning.test.bahaso.com/getpluginfile.php/18/question/questiontext/13766/1/67289/rev%201%20Hello%20I%20am%20Karen%20my%20name%20is%20Karen.mp4",
    ),
    TextQuestion(question: "Karen: Hello! I am Karen. My name is Karen."),
    TextQuestion(question: "Karen: Halo nama saya Karen. Senang bertemu kalian semua."),
    TextQuestion(question: "Karen: He is Kevin. His name is Kevin."),
    TextQuestion(question: "Karen: Dia adalah Kevin. Nama dia adalah Kevin."),
    TextQuestion(question: "Karen: She is Daisy. Her name is Daisy."),
    TextQuestion(question: "Karen: Dia adalah Daisy. Nama dia adalah Daisy."),
    TextQuestion(question: "Karen: What is your name?"),
    TextQuestion(question: "Karen: Siapa nama kamu?"),
  ]),
  DescriptionQuestion(questionNumber: "i.2", questionDisplays: [
    TextQuestion(question: "Klik audio dan pelajari cara pengucapannya"),
    ImageQuestion(
      question:
          "https://learning.test.bahaso.com/getpluginfile.php/18/question/questiontext/13766/2/67291/1%20Karen%20melambaikan%20tangan.png",
    ),
    AudioQuestion(
      question:
          "https://learning.test.bahaso.com/getpluginfile.php/18/question/questiontext/13766/2/67291/1%20Hello%20%28Karen%20melambaikan%20tangan%29.mp3",
    ),
    TextQuestion(question: "Hello!"),
    TextQuestion(question: "Halo"),
    ImageQuestion(
      question:
          "https://learning.test.bahaso.com/getpluginfile.php/18/question/questiontext/13766/2/67291/2%20Karen%20menunjuk%20dirinya%20sendiri.png",
    ),
    AudioQuestion(
      question:
          "https://learning.test.bahaso.com/getpluginfile.php/18/question/questiontext/13766/2/67291/2%20My%20name%20is%20Karen%20%28Karen%20menunjuk%20dirinya%20sendiri%29.mp3",
    ),
    TextQuestion(question: "My name is Karen."),
    TextQuestion(question: "Nama saya adalah Karen."),
    ImageQuestion(
      question:
          "https://learning.test.bahaso.com/getpluginfile.php/18/question/questiontext/13766/2/67291/3%20Karen%20menunjuk%20Kevin.png",
    ),
    AudioQuestion(
      question:
          "https://learning.test.bahaso.com/getpluginfile.php/18/question/questiontext/13766/2/67291/3%20His%20name%20is%20Kevin%20%28Karen%20menunjuk%20Kevin%29.mp3",
    ),
    TextQuestion(question: "His name is Kevin."),
    TextQuestion(question: "Nama dia adalah Kevin."),
    ImageQuestion(
      question:
          "https://learning.test.bahaso.com/getpluginfile.php/18/question/questiontext/13766/2/67291/4%20Karen%20menunjuk%20Daisy.png",
    ),
    AudioQuestion(
      question:
          "https://learning.test.bahaso.com/getpluginfile.php/18/question/questiontext/13766/2/67291/4%20Her%20name%20is%20Daisy%20%28Karen%20menunjuk%20Daisy%29.mp3",
    ),
    TextQuestion(question: "Her name is Daisy"),
    TextQuestion(question: "Nama dia adalah Daisy."),
    ImageQuestion(
      question:
          "https://learning.test.bahaso.com/getpluginfile.php/18/question/questiontext/13766/2/67291/5%20Karen%20membungkuk%20sopan.png",
    ),
    AudioQuestion(
      question:
          "https://learning.test.bahaso.com/getpluginfile.php/18/question/questiontext/13766/2/67291/5%20Nice%20to%20meet%20you%20%28Karen%20membungkuk%20sopan%29.mp3",
    ),
    TextQuestion(question: "Nice to meet you."),
    TextQuestion(question: "Senang bertemu denganmu."),
  ]),
  MultipleChoiceQuestion(
    questionNumber: 3,
    questionDisplays: [
      TextQuestion(question: "Dengarkan audio berikut dan pilih jawaban yang tepat"),
      AudioQuestion(
        question:
            "https://learning.test.bahaso.com/getpluginfile.php/18/question/questiontext/13766/8/67304/My%20name%20is%20Diana.mp3",
      ),
      TextQuestion(question: "What is her name?"),
    ],
    answers: [
      Answer(text: "Her name is Briana.", value: "0", name: "q13766:8_answer"),
      Answer(text: "Her name is Jack.", value: "1", name: "q13766:8_answer"),
      Answer(text: "Her name is Diana.", value: "2", name: "q13766:8_answer"),
    ],
    correctAnswer: "1",
  ),
  MultipleChoiceQuestion(
    questionNumber: 4,
    questionDisplays: [
      TextQuestion(question: "Perhatikan gambar dan pilih jawaban yang tepat"),
      ImageQuestion(
        question: "https://learning.test.bahaso.com/getpluginfile.php/18/question/questiontext/13766/12/67316/SBY.png",
      ),
      TextQuestion(question: "Who is he?"),
    ],
    answers: [
      Answer(text: "Her name is Susilo.", value: "0", name: "q13766:12_answer"),
      Answer(text: "His name is Susilo.", value: "1", name: "q13766:12_answer"),
      Answer(text: "She is Susilo.", value: "2", name: "q13766:12_answer"),
    ],
    correctAnswer: "1",
  ),
];



//     {
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
//     {
//       "question": [
//         "Perhatikan percakapan berikut ini",
//         "https://learning.test.bahaso.com/getpluginfile.php/18/question/questiontext/13766/16/67330/Ben%20nunjuk%20Karen.jpg?time=1692342557585",
//         "https://learning.test.bahaso.com/getpluginfile.php/18/question/questiontext/13766/16/67330/This%20is%20my%20friend%20%28conversation%29.mp3?time=1692342640330",
//         "Ben : This is my friend. Her name is Karen."
//       ],
//       "questionnumber": "i.4",
//       "typequestion": "description",
//       "name": "q13766:16_:sequencecheck",
//       "value": "1",
//       "grade": 0,
//       "data": [
        
//       ]
//     },
//     {
//       "question": [
//         "Perhatikan percakapan berikut ini",
//         "https://learning.test.bahaso.com/getpluginfile.php/18/question/questiontext/13766/17/67332/17.%20fix%20gambar%20seorang%20pria%20menunjuk%20seorang%20wanita%20dan%20seorang%20pria.%20.png",
//         "https://learning.test.bahaso.com/getpluginfile.php/18/question/questiontext/13766/17/67332/These%20are%20my%20friends.mp3",
//         "Ben : These are my friends. Their names are Daisy and Kevin."
//       ],
//       "questionnumber": "i.5",
//       "typequestion": "description",
//       "name": "q13766:17_:sequencecheck",
//       "value": "1",
//       "grade": 0,
//       "data": [
        
//       ]
//     },
//     {
//       "question": [
//         "Pasangkan gambar berikut dengan keterangan yang benar",
//         " blank",
//         " blank"
//       ],
//       "questionnumber": 7,
//       "typequestion": "ddwtos",
//       "name": "q13766:18_:sequencecheck",
//       "value": "1",
//       "grade": 1,
//       "data": {
//         "dataimage": [
//           {
//             "urlimage": "https://learning.test.bahaso.com/getpluginfile.php/18/question/questiontext/13766/18/67334/12.%20Anak-laki-laki-menunjuk-ke-satu-orang-anak_.png?time=1692343012763",
//             "slot": 0
//           },
//           {
//             "urlimage": "https://learning.test.bahaso.com/getpluginfile.php/18/question/questiontext/13766/18/67334/17.%20fix%20gambar%20seorang%20pria%20menunjuk%20seorang%20wanita%20dan%20seorang%20pria.%20.png",
//             "slot": 1
//           }
//         ],
//         "dataplace": [
//           {
//             "name": "q13766:18_p1",
//             "value": "0"
//           },
//           {
//             "name": "q13766:18_p2",
//             "value": "0"
//           }
//         ],
//         "datachoice": [
//           {
//             "name": "These are my friends.",
//             "value": 1
//           },
//           {
//             "name": "This is my friend.",
//             "value": 2
//           }
//         ]
//       }
//     },
//     {
//       "question": [
//         "Pilih jawaban yang tepat",
//         "My name  blank Ben.",
//         "Her name  blank Daisy.",
//         "His name  blank Kevin.",
//         "Their names  blank Karen and Diana."
//       ],
//       "questionnumber": 8,
//       "typequestion": "ddwtos",
//       "name": "q13766:22_:sequencecheck",
//       "value": "1",
//       "grade": 1,
//       "data": {
//         "dataimage": [
          
//         ],
//         "dataplace": [
//           {
//             "name": "q13766:22_p1",
//             "value": "0"
//           },
//           {
//             "name": "q13766:22_p2",
//             "value": "0"
//           },
//           {
//             "name": "q13766:22_p3",
//             "value": "0"
//           },
//           {
//             "name": "q13766:22_p4",
//             "value": "0"
//           }
//         ],
//         "datachoice": [
//           {
//             "name": "are",
//             "value": 1
//           },
//           {
//             "name": "is",
//             "value": 2
//           }
//         ]
//       }
//     },
//     {
//       "question": "Pilih verb be yang tepat untuk kalimat di bawah ini",
//       "questionnumber": 9,
//       "typequestion": "match",
//       "name": "q13766:27_:sequencecheck",
//       "value": "1",
//       "grade": 1,
//       "data": {
//         "dataoptions": [
//           "Choose...",
//           "are",
//           "am",
//           "is"
//         ],
//         "datatext": [
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
//       }
//     }