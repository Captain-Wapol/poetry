import 'package:flutter/material.dart';
import 'package:poetry/utils.dart';

class PrimarySchoolWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PrimarySchoolState();
}

class PrimarySchoolState extends State<PrimarySchoolWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("小学读本"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        builder: _buildFuture,
        future: DefaultAssetBundle.of(context)
            .loadString('asset/primarySchool.json',cache: false),
      ),
    );
  }

  Widget _buildFuture(BuildContext context, AsyncSnapshot snapshot) {
    return UTILS.fBuildFuture(context, snapshot, _createListView);
  }

  Widget _createListView(BuildContext context, Map<String, dynamic> data) {
    List results = data["lessons"];

    void _itemOntab(String title, String id) {
      /* Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return PoetryDetailWidget(title, id);
      })); */
    }

    return ListView.builder(
      itemCount: results.length,
      //itemExtent: 50.0,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            _itemOntab(results[index]["title"], results[index]["id"]);
          },
          child: Container(
              padding: EdgeInsets.only(top: 5.0, left: 15.0, bottom: 5.0),
              decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(color: Colors.black12, width: 1)),
              ),
              child: ListTile(
                leading: Icon(Icons.star_border, color: Colors.deepOrange[200]),
                title: Text(results[index]["title"]),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {},
              )),
        );
      },
    );
  }
}
