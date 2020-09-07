import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<Photo>> fetchPhotos(http.Client client) async {
  final response =
      await client.get('https://www.json-generator.com/api/json/get/cflKVKLwAy?indent=2');

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parsePhotos, response.body);
}

// A function that converts a response body into a List<Photo>.
List<Photo> parsePhotos(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
}

class Photo {
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  Photo({this.albumId, this.id, this.title, this.url, this.thumbnailUrl});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      albumId: json['albumId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      url: json['url'] as String,
      thumbnailUrl: json['picture'] as String,
    );
  }
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Isolate Demo';

    return MaterialApp(
      title: appTitle,
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: appTitle),
      theme: ThemeData.dark(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Photo>>(
        future: fetchPhotos(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? PhotosList(photos: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class PhotosList extends StatelessWidget {
  final List<Photo> photos;

  PhotosList({Key key, this.photos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: photos.length,
      itemBuilder: (context, index) {
        return Image.network(photos[index].thumbnailUrl);
      },
    );
  }
}
// class Cardlar extends StatefulWidget {
//   @override
//   _CardlarState createState() => _CardlarState();
// }

// class _CardlarState extends State<Cardlar> {
//   Future<List<CardJson>> _getCard() async {
//     var data = await http
//         .get("http://www.json-generator.com/api/json/get/cfSIWWEMfC?indent=2");

//     var jsonData = json.decode(data.body);
//     List<CardJson> cards = [];
//     for (var c in jsonData) {
//       CardJson card =
//           CardJson(c["index"], c["ay"], c["picture"], c["sayi"], c["dergiadi"]);
//       cards.add(card);
//     }
//     print(cards.toString());
//     return cards;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         child: FutureBuilder(
//           future: _getCard(),
//           builder: (BuildContext context, AsyncSnapshot snapshot) {
//             print(_getCard().toString());
//             if (snapshot.data == null) {
//               return Container(
//                 child: Center(child: CircularProgressIndicator()),
//               );
//             } else {
//               return ListView.builder(
//                   itemCount: snapshot.data.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     return GestureDetector(
//                         child: Card(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(18.0),
//                           ),
//                           //color: Color(0xFF333333),
//                           elevation: 10.0,
//                           margin: EdgeInsets.all(10),
//                           child: new Stack(
//                             children: <Widget>[
//                               ClipRRect(
//                                 borderRadius: BorderRadius.only(
//                                   topLeft: const Radius.circular(18.0),
//                                   topRight: const Radius.circular(18.0),
//                                 ),
//                                 child: Image.network(
//                                   snapshot.data[index].picture,
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                               Container(
//                                 height: 80,
//                                 margin: EdgeInsets.only(top: 535, left: 15),
//                                 child: Text(
//                                   snapshot.data[index].dergiadi,
//                                   style: TextStyle(
//                                     fontSize: 25.0,
//                                     fontFamily: 'Helvetica',
//                                     //color: Colors.white,
//                                   ),
//                                 ),
//                               ),
//                               Container(
//                                 margin: EdgeInsets.only(top: 580, left: 280),
//                                 child: Text(
//                                   snapshot.data[index].ay,
//                                   style: TextStyle(
//                                     fontSize: 15.0,
//                                     fontFamily: 'RobotoLight',
//                                     //  color: Colors.white
//                                   ),
//                                 ),
//                               ),
//                               Container(
//                                 margin: EdgeInsets.only(top: 580, left: 15),
//                                 child: Text(
//                                   "Sayı : " +
//                                       snapshot.data[index].sayi.toString(),
//                                   style: TextStyle(
//                                     fontSize: 15.0,
//                                     fontFamily: 'RobotoLight',
//                                     // color: Colors.white
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         onTap: () {
//                           if (snapshot.data[index].index == 0) {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) =>
//                                         DetailPage(snapshot.data[index])));
//                           } else if (snapshot.data[index].index == 1) {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) =>
//                                         DetailPage(snapshot.data[index])));
//                           } else if (snapshot.data[index].index == 2) {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) =>
//                                         DetailPage(snapshot.data[index])));
//                           } else if (snapshot.data[index].index == 3) {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) =>
//                                         DetailPage(snapshot.data[index])));
//                           } else if (snapshot.data[index].index == 4) {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) =>
//                                         DetailPage(snapshot.data[index])));
//                           } else if (snapshot.data[index].index == 5) {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) =>
//                                         DetailPage(snapshot.data[index])));
//                           } else {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) =>
//                                         DetailPage(snapshot.data[index])));
//                           }
//                         });
//                   });
//             }
//           },
//         ),
//       ),
//     );
//   }
// }

// class DetailPage extends StatelessWidget {
//   final CardJson text;
//   DetailPage(this.text);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(text.dergiadi),
//       ),
//       body: Center(
//         child: Text(" Sayi : " + text.sayi.toString() + "\n" + text.ay),
//       ),
//     );
//   }
// }
