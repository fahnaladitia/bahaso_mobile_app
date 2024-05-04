import 'package:logger/logger.dart';

final logger = Logger();
const reqresAPI = 'https://reqres.in/api';
const bahasoAPI = 'https://devbe.bahaso.com/api';

final regexMp4 = RegExp(r'https?:\/\/.*\.mp4(\?.*)?$');
final regexImage = RegExp(r'https?:\/\/.*\.(?:png|jpg|jpeg|gif)(\?.*)?$');
final regexAudio = RegExp(r'https?:\/\/.*\.(?:mp3|wav|ogg)(\?.*)?$');
final blankRegex = RegExp(r' blank');
