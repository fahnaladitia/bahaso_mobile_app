import 'package:equatable/equatable.dart';

sealed class Answer extends Equatable {
  const Answer();
  @override
  List<Object?> get props => [];
}

class TextAnswer extends Answer {
  final String text;
  final String name;
  final String value;

  const TextAnswer({
    required this.text,
    required this.name,
    required this.value,
  });

  @override
  List<Object?> get props => [text, name, value];

  @override
  bool get stringify => true;
}
