import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';

void main() {
  runApp(MyApp());
}

//Tema Ayarları
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Firebase Resim Ekleme'),
    );
  }
}

//Global Değişkenler
File resim;
String resimYolu;

//Stf wideget
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future _resimAl() async {
    var secilenResim = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      resim = secilenResim;
      resimYolu = basename(resim.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: resim == null ? Text("Resim Seçin") : yuklemeAlani(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _resimAl,
        child: Icon(Icons.image),
      ),
    );
  }
}

Widget yuklemeAlani() {
  return Column(
    children: [
      Image.file(
        resim,
        width: double.infinity,
        height: 500,
      ),
      RaisedButton(
          color: Colors.blue,
          textColor: Colors.white,
          child: Text("Resmi Gönder"),
          onPressed: () {
            resmiGonder();
          })
    ],
  );
}

Future<String> resmiGonder() async {
  StorageReference resimYeri = FirebaseStorage.instance.ref().child(resimYolu);
  StorageUploadTask yuklemeGorevi = resimYeri.putFile(resim);
  var indirmeUrl = await (await yuklemeGorevi.onComplete).ref.getDownloadURL();
  var url = indirmeUrl.toString();
  print("İndirme URL= " + url);
  return url;
}
