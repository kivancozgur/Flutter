import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Cards'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
Future<List<CardJson>> _getCard() async {
  var data = await http.get("https://www.json-generator.com/api/json/get/bOHFoYvote?indent=2");

  var jsonData=json.decode(data.body);

  List<CardJson> cards=[];
  for(var c in jsonData){
    CardJson card = CardJson(c["_id"],c["kullaniciAdi"],c["sifre"],c["yetki"]);
    cards.add(card);
  }
  return cards;
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: Container(
        child: FutureBuilder(
          future: _getCard(),
          builder: (BuildContext context,AsyncSnapshot snapshot){
            if(snapshot.data==null){
              return Container(
                child: Center(
                  child:Text("Loading..")
                ),
              );  
            }
            else{
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context,int index){
                
                         // child: Text("Kullanıcı Adi : "+snapshot.data[index].kullaniciAdi + "Sifre : "+ snapshot.data[index].sifre.toString()),
                         print("Kullanıcı Adi : "+snapshot.data[index].kullaniciAdi + "   ---  Sifre : "+ snapshot.data[index].sifre.toString());
                
              }
              );
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
        title: Text(text.yetki.toString()),
      ),
    );
  }
}

class CardJson {
  final int id;
  final String kullaniciAdi;
  final int sifre;
  final int yetki;
  CardJson(this.id,this.kullaniciAdi,this.sifre,this.yetki);
}