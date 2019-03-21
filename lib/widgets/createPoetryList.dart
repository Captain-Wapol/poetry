import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:poetry/utils.dart';
import 'package:poetry/widgets/poetryDetail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreatePoetryList {
  static void getPeotryListData(bool isRead, callback) async {
    String allPeotryListStr =
        await rootBundle.loadString('asset/poetryList.json', cache: false);
    List<dynamic> allPeotryList = json.decode(allPeotryListStr)["poetrys"];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> readPeotryList = prefs.getStringList(UTILS.poetryReadList);
    if (readPeotryList == null) readPeotryList = new List();

    List<dynamic> result = new List();
    for (var i = 0; i < allPeotryList.length; i++) {
      var poetry = allPeotryList[i];
      if (isRead) {
        if (readPeotryList.indexOf(poetry["id"]) >= 0) result.add(poetry);
      } else {
        if (readPeotryList.indexOf(poetry["id"]) < 0) result.add(poetry);
      }
    }
    callback(result);
    // setState(() {
    //   dataList = result;
    // });
    //return result;
  }

  static Widget createListView(BuildContext context, List<dynamic> results) {
    void _itemOntab(String title, String id, String audio) {
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return PoetryDetailWidget(title, id, audio);
      }));
    }

    if (results.length > 0) {
      return ListView.builder(
        itemCount: results.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              _itemOntab(results[index]["title"], results[index]["id"],
                  results[index]["audio"]);
            },
            child: Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Colors.black12, width: 1)),
                ),
                child: Row(children: <Widget>[
                  Icon(Icons.favorite_border, color: Colors.deepOrange[200]),
                  Container(
                    padding: EdgeInsets.only(left: 25),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Text(results[index]["title"],
                                  softWrap: false,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16))),
                          Text(results[index]["author"],
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.black54,
                                  //fontStyle: FontStyle.italic,
                                  fontSize: 12))
                        ]),
                  ),
                ])),
          );
        },
      );
    } else {
      return Container(
          alignment: Alignment.center,
          child: Text("暂无诗词数据",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black54,
                  //fontStyle: FontStyle.italic,
                  fontSize: 18)));
    }
  }
}
