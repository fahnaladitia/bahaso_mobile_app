import 'package:audioplayers/audioplayers.dart';
import 'package:bahaso_mobile_app/domain/models/models.dart';
import 'package:equatable/equatable.dart';

sealed class QuestionDisplay extends Equatable {
  final String data;
  const QuestionDisplay({required this.data});

  @override
  List<Object?> get props => [data];

  @override
  bool get stringify => true;
}

class TextQuestionDisplay extends QuestionDisplay {
  final String text;
  const TextQuestionDisplay({required this.text}) : super(data: text);
}

class ImageQuestionDisplay extends QuestionDisplay {
  final String imageUrl;
  const ImageQuestionDisplay({required this.imageUrl}) : super(data: imageUrl);
}

class AudioQuestionDisplay extends QuestionDisplay {
  final String audioUrl;
  const AudioQuestionDisplay({required this.audioUrl}) : super(data: audioUrl);

  UrlSource get url => UrlSource(audioUrl);
}

class VideoQuestionDisplay extends QuestionDisplay {
  final String videoUrl;
  const VideoQuestionDisplay({required this.videoUrl}) : super(data: videoUrl);

  Uri get url => Uri.parse(videoUrl);
}

class PuzzleTextQuestionDisplay extends QuestionDisplay {
  final String text;
  final List<int> placesIds;
  final List<int> imageSlots;
  const PuzzleTextQuestionDisplay({
    required this.placesIds,
    required this.text,
    this.imageSlots = const [],
  }) : super(data: text);

  String display(List<QuestionDataPlace> place) {
    String display = text;
    for (var i = 0; i < placesIds.length; i++) {
      display = display.replaceFirst(' blank', place[i].choice?.name ?? '_____');
    }
    return display;
  }
}
