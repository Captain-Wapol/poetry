import 'package:flutter/material.dart';
import 'package:poetry/widgets/createPoetryList.dart';
import 'package:poetry/widgets/searchPoetry.dart';

class PoetryListWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PoetryListState();
}

class PoetryListState extends State<PoetryListWidget> {
  List<dynamic> dataList = new List<dynamic>();

  @override
  void initState() {
    super.initState();
    CreatePoetryList.getPeotryListData(false,dataCallBack);
  }
  void dataCallBack(List<dynamic> result ){
    setState(() {
      dataList = result;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: ObjectKey("_title"),
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon:Icon(Icons.search,color:Colors.white,size:30),
            onPressed: (){
              Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) {
            return SearchPoetryWidget(dataList);
          }));
            },
          )
          
        ],
        title: Text("诗词列表"),
        centerTitle: true,
      ),
      body: CreatePoetryList.createListView(context,dataList),
    );
  }

}
