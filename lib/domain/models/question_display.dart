import 'package:audioplayers/audioplayers.dart';
import 'package:bahaso_mobile_app/domain/models/models.dart';
import 'package:equatable/equatable.dart';

sealed class QuestionDisplay extends Equatable {
  const QuestionDisplay();

  @override
  List<Object?> get props => [];

  @override
  bool get stringify => true;
}

class TextQuestionDisplay extends QuestionDisplay {
  final String question;
  const TextQuestionDisplay({required this.question});
}

class ImageQuestionDisplay extends QuestionDisplay {
  final String question;
  const ImageQuestionDisplay({required this.question});
}

class AudioQuestionDisplay extends QuestionDisplay {
  final String question;
  const AudioQuestionDisplay({required this.question});

  UrlSource get url => UrlSource(question);
}

class VideoQuestionDisplay extends QuestionDisplay {
  final String question;
  const VideoQuestionDisplay({required this.question});

  Uri get url => Uri.parse(question);
}

class PuzzleTextQuestionDisplay extends QuestionDisplay {
  final String question;
  final List<int> placesIds;
  final List<int> imageSlots;
  const PuzzleTextQuestionDisplay({
    required this.placesIds,
    required this.question,
    this.imageSlots = const [],
  });

  String display(List<QuestionDataPlace> place) {
    String display = question;
    for (var i = 0; i < placesIds.length; i++) {
      display = display.replaceFirst(' blank', place[i].choice?.name ?? '_____');
    }
    return display;
  }
}



// {
//       "question": [
//         "Pasangkan dengan kata yang tepat",
//         " blank",
//         " blank",
//         " blank",
//         " blank"
//       ],
//       "questionnumber": 1,
//       "typequestion": "ddwtos",
//       "name": "q13766:4_:sequencecheck",
//       "value": "1",
//       "grade": 1,
//       "data": {
//         "dataimage": [
//           {
//             "urlimage": "https://learning.test.bahaso.com/getpluginfile.php/18/question/questiontext/13766/4/67295/1%20Karen%20melambaikan%20tangan.png",
//             "slot": 0
//           },
//           {
//             "urlimage": "https://learning.test.bahaso.com/getpluginfile.php/18/question/questiontext/13766/4/67295/2%20Karen%20menunjuk%20dirinya%20sendiri.png",
//             "slot": 1
//           },
//           {
//             "urlimage": "https://learning.test.bahaso.com/getpluginfile.php/18/question/questiontext/13766/4/67295/3%20Karen%20menunjuk%20Kevin.png",
//             "slot": 2
//           },
//           {
//             "urlimage": "https://learning.test.bahaso.com/getpluginfile.php/18/question/questiontext/13766/4/67295/4%20Karen%20membungkuk%20sopan.png",
//             "slot": 3
//           }
//         ],
//         "dataplace": [
//           {
//             "name": "q13766:4_p1",
//             "value": "0"
//           },
//           {
//             "name": "q13766:4_p2",
//             "value": "0"
//           },
//           {
//             "name": "q13766:4_p3",
//             "value": "0"
//           },
//           {
//             "name": "q13766:4_p4",
//             "value": "0"
//           }
//         ],
//         "datachoice": [
//           {
//             "name": "His name is Kevin.",
//             "value": 1
//           },
//           {
//             "name": "My name is Karen.",
//             "value": 2
//           },
//           {
//             "name": "Nice to meet you!",
//             "value": 3
//           },
//           {
//             "name": "Hello!",
//             "value": 4
//           }
//         ]
//       }
//     },