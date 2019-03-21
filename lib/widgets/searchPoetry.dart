import 'package:flutter/material.dart';

class SearchPoetryWidget extends StatefulWidget {
  final List<dynamic> _dataList;
  SearchPoetryWidget(this._dataList);
  @override
  State<StatefulWidget> createState() => SearchPoetryState(_dataList);
}

class SearchPoetryState extends State<SearchPoetryWidget> {
  List<dynamic> _dataList;
  List<dynamic> _searchList;
  SearchPoetryState(this._dataList);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_searchList == null) _searchList = new List();
    return Scaffold(
      key: ObjectKey("_title"),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("搜索诗词"),
        centerTitle: true,
      ),
      body: _createSearchPoetry(context),
    );
  }

  Widget _createSearchPoetry(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom:5),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.deepOrange[100],
                    offset: Offset(0, 3.0),
                    blurRadius: 8.0,
                    spreadRadius: 1.0)
              ],
            ),
            child: TextField(
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "请输入诗词标题",
                  hintStyle: TextStyle(color: Colors.black45),
                  contentPadding: EdgeInsets.all(10.0),
                  fillColor: Colors.black),
              onChanged: (String word) {
                print(word);
                _search(word);
              },
            )),
        Flexible(
          //padding: EdgeInsets.only(top: 24),
          child: ListView.builder(
              itemCount: _searchList.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    //_itemOntab(dataList[index]["title"], dataList[index]["id"],  dataList[index]["audio"]);
                  },
                  child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: Border(
                            bottom:
                                BorderSide(color: Colors.black12, width: 1)),
                      ),
                      child: Row(children: <Widget>[
                        Icon(Icons.favorite_border,
                            color: Colors.deepOrange[200]),
                        Container(
                          padding: EdgeInsets.only(left: 25),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.only(bottom: 8.0),
                                    child: Text(_searchList[index]["title"],
                                        softWrap: false,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16))),
                                Text(_searchList[index]["author"],
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.black54,
                                        //fontStyle: FontStyle.italic,
                                        fontSize: 12))
                              ]),
                        ),
                      ])),
                );
              }),
        )
      ],
    );
  }

  void _search(String word) {
    List<dynamic> tmpList = new List();
    if (word != "") {
      for (var i = 0; i < _dataList.length; i++) {
        if (_dataList[i]["title"].indexOf(word) >= 0) tmpList.add(_dataList[i]);
      }
    }
    setState(() {
      print(tmpList);
      _searchList = tmpList;
    });
  }
}
