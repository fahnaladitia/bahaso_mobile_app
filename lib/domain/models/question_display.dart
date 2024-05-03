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
