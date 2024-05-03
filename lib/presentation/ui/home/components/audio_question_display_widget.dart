import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import 'package:bahaso_mobile_app/domain/models/models.dart';

class AudioQuestionDisplayWidget extends StatefulWidget {
  final AudioQuestionDisplay audioQuestionDisplay;
  const AudioQuestionDisplayWidget({
    Key? key,
    required this.audioQuestionDisplay,
  }) : super(key: key);

  @override
  State<AudioQuestionDisplayWidget> createState() => _AudioQuestionDisplayWidgetState();
}

class _AudioQuestionDisplayWidgetState extends State<AudioQuestionDisplayWidget> {
  late final AudioPlayer _player;
  PlayerState? _playerState;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    _player.onPlayerStateChanged.listen((event) {
      setState(() {
        _playerState = event;
      });
    });
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).primaryColor;
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200.withOpacity(0.8),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              _playerState == PlayerState.playing
                  ? IconButton(
                      key: const Key('pause_button'),
                      onPressed: _player.pause,
                      iconSize: 24.0,
                      icon: const Icon(Icons.pause),
                      color: color,
                    )
                  : IconButton(
                      key: const Key('play_button'),
                      onPressed: () {
                        _player.play(widget.audioQuestionDisplay.url);
                      },
                      iconSize: 24.0,
                      icon: const Icon(Icons.play_arrow),
                      color: color,
                    ),
              IconButton(
                key: const Key('stop_button'),
                onPressed: _playerState == PlayerState.playing ? _player.stop : null,
                iconSize: 24.0,
                icon: Icon(Icons.stop, color: _playerState == PlayerState.playing ? color : Colors.grey),
                color: color,
              ),
            ],
          ),
          // Slider(
          //   onChanged: (value) async {
          //     final duration = await _player.getDuration();
          //     final position = value * (duration?.inMilliseconds.toDouble() ?? 0.0);
          //     _player.seek(Duration(milliseconds: position.round()));
          //   },

          // ),
          // Text(
          //   _position != null
          //       ? '$_positionText / $_durationText'
          //       : _duration != null
          //           ? _durationText
          //           : '',
          //   style: const TextStyle(fontSize: 16.0),
          // ),
          // const SizedBox(height: 8),
        ],
      ),
    );
  }
}
