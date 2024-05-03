import 'package:audioplayers/audioplayers.dart';
import 'package:equatable/equatable.dart';

sealed class QuestionDisplay extends Equatable {
  final String question;

  const QuestionDisplay({required this.question});

  @override
  List<Object?> get props => [question];

  @override
  bool get stringify => true;
}

class TextQuestion extends QuestionDisplay {
  const TextQuestion({required super.question});
}

class ImageQuestion extends QuestionDisplay {
  const ImageQuestion({required super.question});
}

class AudioQuestion extends QuestionDisplay {
  const AudioQuestion({required super.question});

  UrlSource get url => UrlSource(question);
}

class VideoQuestion extends QuestionDisplay {
  const VideoQuestion({required super.question});

  Uri get url => Uri.parse(question);
}
