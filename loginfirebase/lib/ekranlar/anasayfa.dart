import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loginfirebase/ekranlar/kayitekrani.dart';

class Anasayfa extends StatefulWidget {
  @override
  _AnasayfaState createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Anasayfa "),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              //Firebaseden çıkış
              FirebaseAuth.instance.signOut().then((onValue) {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => KayitEkrani()));
              });
            },
          )
        ],
      ),
    );
  }
}
