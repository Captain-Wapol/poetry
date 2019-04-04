import 'package:flutter/material.dart';
import 'package:poetry/utils.dart';
import 'package:poetry/widgets/audioPlayer.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:poetry/widgets/videoPlayer.dart';
import 'package:video_player/video_player.dart';

enum PlayerState { stopped, playing, paused }

class AlphabetDetailWidget extends StatelessWidget {
  final String _word;

  AlphabetDetailWidget(this._word);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_word),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
      ),
      body: new _DetailWidget(this._word),
    );
  }
}

class _DetailWidget extends StatefulWidget {
  final String _word;
  _DetailWidget(this._word);
  @override
  _AlphabetDetailState createState() => new _AlphabetDetailState(this._word);
}

class _AlphabetDetailState extends State<_DetailWidget> {
  final String _word;
  bool hasRead = false;
  VideoPlayerController _controller;

  _AlphabetDetailState(this._word);
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'http://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: _buildFuture,
      future: DefaultAssetBundle.of(context)
          .loadString('asset/alphabet/' + this._word + '.json', cache: false),
    );
  }

  Widget _buildFuture(BuildContext context, AsyncSnapshot snapshot) {
    return UTILS.fBuildFuture(context, snapshot, _createListView);
  }

  Widget _createListView(BuildContext context, Map<String, dynamic> data) {

    return SingleChildScrollView(
        padding: EdgeInsets.only(top: 14),
        child: Column(
          //mainAxisAlignment:MainAxisAlignment.center,
          children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              MaterialButton(
                child: Container(
                    width: 200,
                    height: 200,
                    alignment: Alignment.center,
                    //padding: EdgeInsets.all(15),
                    decoration: new BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius:
                            BorderRadius.all(const Radius.circular(15)),
                        gradient: RadialGradient(colors: [
                          Colors.deepOrange[50],
                          Colors.deepOrange[100],
                          Colors.deepOrange[200]
                        ], radius: 2)),
                    child: Text(
                      _word,
                      style: TextStyle(fontSize: 120),
                    )),
                onPressed: () {
                  showDialog<Null>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          actions: <Widget>[
                            new FlatButton( 
                              child: new Text(
                                '关闭',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                          content: Image.network(data["bisun"], scale: 0.5),
                        );
                      });
                },
              ),
              
            PlayerWidget(
              url: data["mp3url"],
              fullControl: false,
            ),
              // IconButton(
              //   icon: Icon(Icons.record_voice_over),
              //   onPressed: () => {},
              // )
            ]),
            VideoPlayerWidgt(data["mp4url"])
            // Center(
            //   child: _controller.value.initialized
            //       ? AspectRatio(
            //           aspectRatio: _controller.value.aspectRatio,
            //           child: VideoPlayer(_controller),
            //         )
            //       : Container(),
            // )
            // NetworkPlayerLifeCycle(
            //         data["mp4url"],
            //         (BuildContext context, VideoPlayerController controller) =>
            //             AspectRatioVideo(controller),
            //       )
          ],
        ));
  }
}
