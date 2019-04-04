import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class VideoPlayerWidgt extends StatefulWidget {
  final String _videoUrl;
  @override
  VideoPlayerWidgt(this._videoUrl);
  @override
  _VideoPlayerState createState() => _VideoPlayerState(_videoUrl);
}

class _VideoPlayerState extends State<VideoPlayerWidgt> {
  VideoPlayerController _controller;
  final String _videoUrl;
  @override
  _VideoPlayerState(this._videoUrl);

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(this._videoUrl)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Center(
          child: _controller.value.initialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : Container(),
        ),
        FloatingActionButton(
          onPressed: () {
            setState(() {
              _controller.value.isPlaying
                  ? _controller.pause()
                  : _controller.play();
            });
          },
          child: Icon(
            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        )
        ],);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}