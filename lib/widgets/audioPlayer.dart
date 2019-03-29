import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:audioplayers/audio_cache.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';

enum PlayerState { stopped, playing, paused }

class PlayerWidget extends StatefulWidget {
  final String url;
  final String id;
  final bool isLocal;
  final bool showTime;
  final PlayerMode mode;

  PlayerWidget(
      {@required this.url,
      this.id = "123456789",
      this.isLocal = false,
      this.mode = PlayerMode.MEDIA_PLAYER,
      this.showTime = true});

  @override
  State<StatefulWidget> createState() {
    return new _PlayerWidgetState(url, isLocal, mode, showTime);
  }
}

class _PlayerWidgetState extends State<PlayerWidget> {
  String url;
  bool isLocal;
  bool showTime;
  PlayerMode mode;

  AudioPlayer _audioPlayer;
  AudioPlayerState _audioPlayerState;
  Duration _duration;
  Duration _position;

  PlayerState _playerState = PlayerState.stopped;
  StreamSubscription _durationSubscription;
  StreamSubscription _positionSubscription;
  StreamSubscription _playerCompleteSubscription;
  StreamSubscription _playerErrorSubscription;
  StreamSubscription _playerStateSubscription;

  get _isPlaying => _playerState == PlayerState.playing;
  get _isPaused => _playerState == PlayerState.paused;
  get _durationText => _duration?.toString()?.split('.')?.first ?? '';
  get _positionText => _position?.toString()?.split('.')?.first ?? '';

  _PlayerWidgetState(this.url, this.isLocal, this.mode, this.showTime);

  @override
  void initState() {
    super.initState();
    _initAudioPlayer();
  }

  @override
  void dispose() {
    _audioPlayer.stop();
    _durationSubscription?.cancel();
    _positionSubscription?.cancel();
    _playerCompleteSubscription?.cancel();
    _playerErrorSubscription?.cancel();
    _playerStateSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      new IconButton(
          onPressed: _isPlaying ? () => _pause() : () => _play(),
          iconSize: 64.0,
          icon: _isPlaying ? new Icon(Icons.pause) : new Icon(Icons.play_arrow),
          color: Colors.deepOrange[300])
    ];
    if (showTime)
      children.add(new Text(
        _position != null
            ? '${_positionText ?? ''} / ${_durationText ?? ''}'
            : '0:00:00 / 0:00:00',
        style: new TextStyle(fontSize: 24.0),
      ));
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(right: 24),
      decoration: BoxDecoration(
          color: Colors.grey[200],
          border: Border.all(color: Colors.grey[300], width: 1),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: children,
      ),
    );
  }

  void _initAudioPlayer() {
    _audioPlayer = new AudioPlayer(mode: mode);

    _durationSubscription =
        _audioPlayer.onDurationChanged.listen((duration) => setState(() {
              _duration = duration;
            }));

    _positionSubscription =
        _audioPlayer.onAudioPositionChanged.listen((p) => setState(() {
              _position = p;
            }));

    _playerCompleteSubscription =
        _audioPlayer.onPlayerCompletion.listen((event) {
      _onComplete();
      setState(() {
        _position = _duration;
      });
    });

    _playerErrorSubscription = _audioPlayer.onPlayerError.listen((msg) {
      print('audioPlayer error : $msg');
      setState(() {
        _playerState = PlayerState.stopped;
        _duration = new Duration(seconds: 0);
        _position = new Duration(seconds: 0);
      });
    });

    _audioPlayer.onPlayerStateChanged.listen((state) {
      if (!mounted) return;
      setState(() {
        _audioPlayerState = state;
      });
    });
  }

  Future _loadFile(String url, String id) async {
    final bytes = await readBytes(url);
    final dir = await getApplicationDocumentsDirectory();
    final file = new File('${dir.path}/' + id + 'audio.mp3');

    await file.writeAsBytes(bytes);
    if (await file.exists()) {
      return file.path;
    }
  }

  Future<int> _play() async {
    final playPosition = (_position != null &&
            _duration != null &&
            _position.inMilliseconds > 0 &&
            _position.inMilliseconds < _duration.inMilliseconds)
        ? _position
        : null;
    var localurl = await _loadFile(url, "1234567");
    //final result = await _audioPlayer.play(url, isLocal: isLocal, position: playPosition);
    final result = await _audioPlayer.play(localurl,
        isLocal: true, position: playPosition);
    if (result == 1) setState(() => _playerState = PlayerState.playing);
    return result;
  }

  Future<int> _pause() async {
    final result = await _audioPlayer.pause();
    if (result == 1) setState(() => _playerState = PlayerState.paused);
    return result;
  }

  Future<int> _stop() async {
    final result = await _audioPlayer.stop();
    if (result == 1) {
      setState(() {
        _playerState = PlayerState.stopped;
        _position = new Duration();
      });
    }
    return result;
  }

  void _onComplete() {
    setState(() => _playerState = PlayerState.stopped);
  }
}
