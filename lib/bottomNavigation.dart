import 'package:flutter/material.dart';
import 'package:poetry/widgets/unReadPoetryList.dart';
import 'package:poetry/widgets/alphabet.dart';
import 'package:poetry/widgets/primarySchool.dart';
import 'package:poetry/widgets/personalCenter.dart';

class BottomNavigationWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new BottomNavigationWidgetState();
  }
}

class BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  int _currentIndex = 0;
  List<Widget> pageList = new List();
  @override
  void initState() {
    super.initState();
    pageList
      ..add(new PoetryListWidget())
      ..add(new AlphabetWidget())
      ..add(new PrimarySchoolWidget())
      ..add(new PersonalCenterWidget());
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: pageList[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.list,
              ),
              title: new Text(
                '诗词',
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.business,
              ),
              title: new Text(
                '识字',
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.school,
              ),
              title: new Text(
                '课本',
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person_outline,
              ),
              title: new Text(
                '我的',
              )),
        ],
        currentIndex: _currentIndex,
        onTap: (int i) {
          setState(() {
            _currentIndex = i;
          });
        },
      ),
    );
  }
}
