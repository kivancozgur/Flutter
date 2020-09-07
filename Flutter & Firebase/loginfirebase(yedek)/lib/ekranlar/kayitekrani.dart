import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loginfirebase/ekranlar/anasayfa.dart';
import 'package:loginfirebase/ekranlar/girisekrani.dart';

class KayitEkrani extends StatefulWidget {
  @override
  _KayitEkraniState createState() => _KayitEkraniState();
}

class _KayitEkraniState extends State<KayitEkrani> {
  String email, sifre;

  bool yuklenmeDurumu = false;

  var _formAnahtari = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kayıt Ekranı"),
      ),
      body: yuklenmeDurumu
          ? Center(child: CircularProgressIndicator())
          : Container(
              margin: EdgeInsets.all(16),
              alignment: Alignment.center,
              child: Form(
                key: _formAnahtari,
                child: Container(
                  margin: EdgeInsets.all(16),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        validator: (oge) {
                          return oge.contains("@")
                              ? null
                              : "Geçerli Email Adresi Girin !";
                        },
                        decoration: InputDecoration(
                          hintText: "E-mail Adresi Girin",
                          labelText: "E-mail",
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (oge) {
                          setState(() {
                            email = oge;
                          });
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        validator: (oge) {
                          return oge.length >= 6
                              ? null
                              : "Şifreniz En Az 6 Karakter Olmalı !";
                        },
                        decoration: InputDecoration(
                          hintText: "Şifre Girin",
                          labelText: "Şifre",
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (oge) {
                          setState(() {
                            sifre = oge;
                          });
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.infinity,
                        height: 50,
                        child: RaisedButton(
                          color: Colors.blue,
                          textColor: Colors.white,
                          child: Text(
                            "Kaydol",
                            style: TextStyle(fontSize: 18),
                          ),
                          onPressed: () {
                            kayitEkle();
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => GirisSayfasi(),
                              ),
                            );
                          },
                          child: Text(
                            "Hesabınız Zaten Var mı ?",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        alignment: Alignment.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  void kayitEkle() {
    if (_formAnahtari.currentState.validate()) {
      setState(() {
        yuklenmeDurumu = true;
      });
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: sifre)
          .then((user) {
        //kayıt yapılıyorsa
        setState(() {
          yuklenmeDurumu = false;
        });

        //anasayfaya git
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => Anasayfa()),
            (Route<dynamic> route) => false);
      }).catchError((onError) {
        setState(() {
          yuklenmeDurumu = false;
        });
        Fluttertoast.showToast(msg: "Hata : " + onError.toString());
      });
    }
  }
}
