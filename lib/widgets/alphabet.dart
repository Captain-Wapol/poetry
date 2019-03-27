import 'package:flutter/material.dart';
import 'package:poetry/utils.dart';
import 'package:poetry/widgets/alphabetDetail.dart';

class AlphabetWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AlphabetState();
}

class AlphabetState extends State<AlphabetWidget> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("识字"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        builder: _buildFuture,
        future: DefaultAssetBundle.of(context)
            .loadString('asset/alphabet.json', cache: false),
      ),
    );
  }

  Widget _buildFuture(BuildContext context, AsyncSnapshot snapshot) {
    return UTILS.fBuildFuture(context, snapshot, _createListView);
  }

  Widget _createListView(BuildContext context, Map<String, dynamic> data) {
    List<Widget> words = new List();
    for (var i = 0; i < data["words"].length; i++) {
      words.add(InkWell( 
        onTap: (){
          Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                    print(data["words"][i]["word"]);
                return AlphabetDetailWidget(data["words"][i]["word"]);
              }));
        },
        child:Container(
        width: 70.0,
        height: 70.0,
        alignment: Alignment(0.0, 0.0),
        decoration: BoxDecoration(
          color: Colors.white,
          //gradient: RadialGradient(colors:[Colors.white,Colors.white70]),
          border: Border.all(color: Colors.deepOrange[100], width: 1),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
           boxShadow: <BoxShadow>[
              BoxShadow(
                  blurRadius: 3.0,
                  color: Colors.black12,
                  offset: Offset(0.0, 1.0))
            ] 
        ),
        child: Text(
          data["words"][i]["word"],
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
        ),
      )));
    }

    return Container(
        alignment: Alignment(0.0, 0.0),
        child: SingleChildScrollView(
            padding: EdgeInsets.only(top:16.0),

            //alignment: Alignment(0.0, 0.0),
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              alignment: WrapAlignment.start,
              children: words,
            )));
  }
}
