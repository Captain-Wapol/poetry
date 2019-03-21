import 'package:flutter/material.dart';
import 'package:poetry/widgets/createPoetryList.dart';
import 'package:poetry/widgets/searchPoetry.dart';

class ReadPoetryListWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ReadPoetryListState();
}

class ReadPoetryListState extends State<ReadPoetryListWidget> {
  List<dynamic> dataList = new List<dynamic>();

  @override
  void initState() {
    super.initState();
    CreatePoetryList.getPeotryListData(true, dataCallBack);
  }

  void dataCallBack(List<dynamic> result) {
    setState(() {
      dataList = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: ObjectKey("_title"),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search, color: Colors.white, size: 30),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return SearchPoetryWidget(dataList);
              }));
            },
          )
        ],
        title: Text("已学诗词列表"),
        centerTitle: true,
      ),
      body: CreatePoetryList.createListView(context, dataList),
    );
  }
}
