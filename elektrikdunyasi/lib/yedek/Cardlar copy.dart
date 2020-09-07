import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Cardlar extends StatefulWidget {
  @override
  _CardlarState createState() => _CardlarState();
}

class CardJson {
  var index;
  var ay;
  var picture;
  var sayi;
  var dergiadi;
  CardJson(this.index, this.ay, this.picture, this.sayi, this.dergiadi);
}

class _CardlarState extends State<Cardlar> {
  Future<List<CardJson>> _getCard() async {
    var data = await http
        .get("https://www.json-generator.com/api/json/get/ceOopMUcKq?indent=2");

    var jsonData = json.decode(data.body);
    List<CardJson> cards = [];
    for (var c in jsonData) {
      CardJson card =
          CardJson(c["index"], c["ay"], c["picture"], c["sayi"], c["dergiadi"]);
      cards.add(card);
    }
    print(cards.toString());
    return cards;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder(
          future: _getCard(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            print(_getCard().toString());
            if (snapshot.data == null) {
              return Container(
                child: Center(child: CircularProgressIndicator()),
              );
            } else {
              return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height /1.5),
                  ),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    print(snapshot.data[index].picture.toString());
                    return GestureDetector(
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          //color: Color(0xFF333333),
                          elevation: 10.0,
                          margin: EdgeInsets.all(10),
                          child: new Stack(
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(18.0),
                                ),
                                child: Center(
                                  child: Image.network(
                                    snapshot.data[index].picture,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 130, left: 10),
                                child: Text(
                                  snapshot.data[index].dergiadi,
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    backgroundColor: Colors.black,
                                    fontFamily: 'Helvetica',

                                    //color: Colors.white,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 150, left: 10),
                                child: Text(
                                  snapshot.data[index].ay,
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontFamily: 'RobotoLight',
                                    backgroundColor: Colors.black,
                                    //  color: Colors.white
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 150, left: 100),
                                child: Text(
                                  "Sayı : " +
                                      snapshot.data[index].sayi.toString(),
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontFamily: 'RobotoLight',
                                    backgroundColor: Colors.black,
                                    // color: Colors.white
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          if (snapshot.data[index].index == 0) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DetailPage(snapshot.data[index])));
                          } else if (snapshot.data[index].index == 1) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DetailPage(snapshot.data[index])));
                          } else if (snapshot.data[index].index == 2) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DetailPage(snapshot.data[index])));
                          } else if (snapshot.data[index].index == 3) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DetailPage(snapshot.data[index])));
                          } else if (snapshot.data[index].index == 4) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DetailPage(snapshot.data[index])));
                          } else if (snapshot.data[index].index == 5) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DetailPage(snapshot.data[index])));
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DetailPage(snapshot.data[index])));
                          }
                        });
                  });
            }
          },
        ),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final CardJson text;
  DetailPage(this.text);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(text.dergiadi),
      ),
      body: Center(
        child: Text(" Sayi : " + text.sayi.toString() + "\n" + text.ay),
      ),
    );
  }
}
