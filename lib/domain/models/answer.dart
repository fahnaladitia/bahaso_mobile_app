import 'package:equatable/equatable.dart';

class Answer extends Equatable {
  final String text;
  final String name;
  final String value;

  const Answer({
    required this.text,
    required this.name,
    required this.value,
  });

  @override
  List<Object?> get props => [text, name, value];

  @override
  bool get stringify => true;
}
