import 'package:flutter/material.dart';
import 'package:poetry/utils.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

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
  AudioPlayer _audioPlayer = new AudioPlayer();
  final String _word;
  bool hasRead = false;
  _AlphabetDetailState(this._word);
  @override
  void initState() {
    super.initState();
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
    final videoPlayerController = VideoPlayerController.network(data["mp4url"]);
    print(data["imageurl"]);
    return SingleChildScrollView(
        padding: EdgeInsets.only(top: 14),
        child: Column(
          //mainAxisAlignment:MainAxisAlignment.center,
          children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              MaterialButton(
                child: Container(
                  padding: EdgeInsets.all(15),
                    decoration: new BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.all(const Radius.circular(15)),
                      gradient:RadialGradient(colors: [Colors.deepOrange[50], Colors.deepOrange[100], Colors.deepOrange[200]],radius: 2)
                    ),
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
              IconButton(
                icon: Icon(Icons.record_voice_over),
                onPressed: () => {              
                    _audioPlayer.play(data["mp3url"], isLocal: false)
                },
              )
            ])
          ],
        ));
  }
}
