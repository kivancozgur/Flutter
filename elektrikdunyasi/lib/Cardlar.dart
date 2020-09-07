import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Animation/FadeAnimation.dart';

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
                child: Center(child: CircularProgressIndicator()),
              );
            } else {
              return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height / 1.4),
                  ),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          elevation: 10.0,
                          margin: EdgeInsets.all(10),
                          child: FadeAnimation(
                            2,
                            GridTile(
                              footer: FadeAnimation(
                                3,
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(18.0),
                                    bottomLeft: Radius.circular(18.0),
                                  ),
                                  child: Container(
                                    color: Colors.blue[800].withOpacity(0.9),
                                    child: Center(
                                      child: new FadeAnimation(
                                        4,
                                        Text(
                                          snapshot.data[index].ay +
                                              "\nSayi : " +
                                              snapshot.data[index].sayi
                                                  .toString(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(18.0),
                                ),
                                child: Image.network(
                                  snapshot.data[index].picture,
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
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
  var myTextSize = 20.0;
  DetailPage(this.text);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(text.dergiadi),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            FadeAnimation(
              1,
              ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(18.0),
                ),
                child: Image.network(
                  text.picture,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(10),
                  child: Flexible(
                    child: FadeAnimation(
                      2,
                      Text(
                        "\nSayi : " + text.sayi.toString(),
                        maxLines: 2,
                        style: new TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: myTextSize,
                          fontWeight: FontWeight.w300,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
                FadeAnimation(
                  3,
                  Text(
                    "\n" + text.ay,
                    style: new TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: myTextSize,
                      fontWeight: FontWeight.w400,
                    ),
                    overflow: TextOverflow.fade,
                  ),
                ),
              ],
            ),
            // Text(
            //   text.dergiadi +
            //       "\n" +
            //       text.ay +
            //       "\nSayi : " +
            //       text.sayi.toString(),
            //   style: TextStyle(
            //     fontSize: 15.0,
            //     fontFamily: 'Helvetica',
            //   ),
            // ),
          ],
        ),
        // child: Center(
        //   child: new Text(
        //     text.dergiadi + "\n" + text.ay + "\nSayi : " + text.sayi.toString(),
        //     style: TextStyle(
        //       fontSize: 15.0,
        //       fontFamily: 'Helvetica',
        //     ),
        //   ),
        // ),

        // child: Text(" Sayi : " + text.sayi.toString() + "\n" + text.ay),
      ),
      floatingActionButton: Container(
        child: FadeAnimation(
          4,
          FloatingActionButton(
            child: Icon(Icons.file_download),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
