import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Eglence.dart';
import 'Kuafor.dart';
import 'Pub.dart';
import 'Restoran.dart';
import 'Taksi.dart';
import 'TopluTasima.dart';

class Cardlar extends StatefulWidget {
  @override
  _CardlarState createState() => _CardlarState();
}

class CardJson {
  final int index;
  final String about;
  final String picture;
  final String subabout;
  final String name;
  CardJson(this.index, this.about, this.picture, this.subabout, this.name);
}

class _CardlarState extends State<Cardlar> {
  Future<List<CardJson>> _getCard() async {
    var data = await http
        .get("http://www.json-generator.com/api/json/get/cfwkAMZBSG?indent=2");

    var jsonData = json.decode(data.body);

    List<CardJson> cards = [];
    for (var c in jsonData) {
      CardJson card = CardJson(
          c["index"], c["about"], c["picture"], c["subabout"], c["name"]);
      cards.add(card);
    }
    return cards;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder(
          future: _getCard(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Center(child: Text("Loading..")),
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          color: Color(0xFF6D4DD4),
                          elevation: 10.0,
                          margin: EdgeInsets.only(
                              left: 30.0, top: 10.0, bottom: 25.0, right: 30.0),
                          child: new Stack(
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: const Radius.circular(18.0),
                                  topRight: const Radius.circular(18.0),
                                ),
                                child: Image.network(
                                  snapshot.data[index].picture,
                                  width: 600.0,
                                  height: 200.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                height: 125,
                                margin: EdgeInsets.only(top: 150, left: 15),
                                child: Text(
                                  snapshot.data[index].name,
                                  style: TextStyle(
                                    fontSize: 35.0,
                                    fontFamily: 'Helvetica',
                                    color: Colors.white,
                                    backgroundColor: Colors.black,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 210, left: 15),
                                child: Text(
                                  snapshot.data[index].subabout,
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontFamily: 'RobotoLight',
                                      color: Colors.white),
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
                                    builder: (context) => Restoran()));
                          } else if (snapshot.data[index].index == 1) {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => Pub()));
                          } else if (snapshot.data[index].index == 2) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Eglence()));
                          } else if (snapshot.data[index].index == 3) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Taksi()));
                          } else if (snapshot.data[index].index == 4) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TopluTasima()));
                          } else if (snapshot.data[index].index == 5) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Kuafor()));
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
        title: Text(text.name),
      ),
    );
  }
}
