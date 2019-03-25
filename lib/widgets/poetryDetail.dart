import 'package:flutter/material.dart';
import 'package:poetry/utils.dart';
import 'package:poetry/widgets/audioPlayer.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _poetryReadList = "poetryReadList";

class PoetryDetailWidget extends StatelessWidget {
  final String _title;
  final String _id;
  final String _audio;

  PoetryDetailWidget(this._title, this._id, this._audio);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_title),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          centerTitle: true,
        ),
        body: new _DetailWidget(_id, this._audio),
      );
  }
}

class _DetailWidget extends StatefulWidget {
  final String _id;
  final String _audio;
  _DetailWidget(this._id, this._audio);
  @override
  _PoetryDetailState createState() =>
      new _PoetryDetailState(this._id, this._audio);
}

class _PoetryDetailState extends State<_DetailWidget> {
  final String _id;
  final String _audio;
  bool hasRead = false;
  _PoetryDetailState(this._id, this._audio);
  @override
  void initState() {
    super.initState();
    _setPoetryReadStatus(_id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: _buildFuture,
      future: DefaultAssetBundle.of(context)
          .loadString('asset/poetry/' + this._id + '.json', cache: false),
    );
  }

  Widget _buildFuture(BuildContext context, AsyncSnapshot snapshot) {
    return UTILS.fBuildFuture(context, snapshot, _createListView);
  }

  Widget _createListView(BuildContext context, Map<String, dynamic> data) {
    return SingleChildScrollView(
        padding: EdgeInsets.all(14.0),
        child: Column(
          children: <Widget>[
            //标题
            Container(
              child: Text(data["title"],
                  style: TextStyle(
                      color: Colors.black, fontSize: 25, height: 1.5)),
            ),
            //作者
            Container(
              padding: EdgeInsets.only(top: 8),
              child: Text("${data["dynasty"] ?? ''} · ${data["author"] ?? ''}",
                  style: TextStyle(color: Colors.black54, fontSize: 16)),
            ),
            //正文
            Container(
              //color: Colors.red,
              alignment: Alignment.center,
              child: Text(data["content"],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black87, fontSize: 20, height: 2.0)),
            ),
            PlayerWidget(url: this._audio,id: this._id),
            Padding(
              padding: EdgeInsets.only(top: 24),
              child: MaterialButton(
                color: hasRead ? Colors.blueAccent : Colors.deepOrange[500],
                textColor: Colors.white,
                child: hasRead
                    ? new Text(
                        '重新学',
                        style: TextStyle(letterSpacing: 1, fontSize: 16),
                      )
                    : new Text('学会啦',
                        style: TextStyle(letterSpacing: 1, fontSize: 16)),
                onPressed: () {
                  _changePoetryReadStatus(_id);
                },
              ),
            ),

            //注释
            Container(
              alignment: Alignment.center,
              //padding: EdgeInsets.only(top: 14),
              child: Text(data["note"],
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                    height: 1.5,
                  )),
            )
          ],
        ));
  }

  void _setPoetryReadStatus(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> results = prefs.getStringList(_poetryReadList);
    if (results == null) return;
    if (results.indexOf(id) >= 0)
      setState(() {
        hasRead = true;
      });
  }

  void _changePoetryReadStatus(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> results = prefs.getStringList(_poetryReadList);
    if (results == null) results = new List();
    if (hasRead) {
      results.remove(id);
    } else {
      results.add(id);
    }
    prefs.setStringList(_poetryReadList, results);
    setState(() {
      if (hasRead) {
        hasRead = false;
      } else {
        hasRead = true;
      }
    });
  }
}
