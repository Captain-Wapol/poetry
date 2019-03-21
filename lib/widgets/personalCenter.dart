import 'package:flutter/material.dart';
import 'package:poetry/widgets/readPoetryList.dart';

class PersonalCenterWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PersonalCenterState();
}

class PersonalCenterState extends State<PersonalCenterWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("小学读本"),
          centerTitle: true,
        ),
        body: Container(
          color: Colors.black12,
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.black26, width: 1),
                  ),
                ),
                margin: EdgeInsets.only(bottom: 15.0),
                child: Image(
                  image: AssetImage("asset/images/personal.jpg"),
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fitWidth,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.black12, width: 1),
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    _buildListTile(
                        Icon(Icons.timer, color: Colors.deepOrange[200]),
                        "打卡",
                        () {}),
                    _buildListTile(
                        Icon(Icons.cloud_done, color: Colors.deepOrange[200]),
                        "已学诗词", () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return ReadPoetryListWidget();
                      }));
                    })
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Widget _buildListTile(Icon icon, String text, onTap) {
    return Container(
      padding: EdgeInsets.only(top: 2.0, left: 15.0, bottom: 2.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.black12, width: 1),
        ),
      ),
      child: ListTile(
        leading: icon,
        title: Text(text),
        trailing: Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
