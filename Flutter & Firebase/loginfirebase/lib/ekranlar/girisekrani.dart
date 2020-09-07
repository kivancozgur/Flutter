import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loginfirebase/Animation/FadeAnimation.dart';
import 'package:loginfirebase/ekranlar/anasayfa.dart';
import 'package:loginfirebase/ekranlar/kayitekrani.dart';

class GirisSayfasi extends StatefulWidget {
  @override
  _GirisSayfasiState createState() => _GirisSayfasiState();
}

class _GirisSayfasiState extends State<GirisSayfasi> {
  //DEĞİŞKENLER
  Color gradientStart =
      Colors.deepPurple[700]; //Change start gradient color here
  Color gradientEnd = Colors.purple[500]; //Change end gradient color here
  List<Color> signInGradients = [
    Color(0xFF0EDED2),
    Color(0xFF03A0FE),
  ];
  List<Color> signUpGradients = [
    Color(0xFFFF9945),
    Color(0xFFFc6076),
  ];

  String _email, _sifre;
  bool yuklenmeDurumu = false;
  var _formAnahtari = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: yuklenmeDurumu
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              margin: EdgeInsets.only(right: 20, left: 20,top: 16),
              alignment: Alignment.center,
              child: Form(
                key: _formAnahtari,
                child: Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
                    alignment: Alignment.center,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100.0),
                            child: new Image.network(
                              "https://avatars3.githubusercontent.com/u/34067601?v=4",
                              width: 200,
                              height: 200,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          FadeAnimation(
                            1,
                            Text(
                              "Hoşgeldiniz",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          FadeAnimation(
                            3,
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              validator: (oge) {
                                return oge.contains("@")
                                    ? null
                                    : "Geçerli Email Adresi Girin !";
                              },
                              onChanged: (oge) {
                                setState(() {
                                  _email = oge;
                                });
                              },
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.mail_outline,
                                  color: Colors.blue,
                                ),
                                hintText: "E-mail Girin",
                                labelText: "E-mail",
                                helperText: 'E-mail adresiniz geçerli olmalı',
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blue[700], width: 2.0),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.lightBlue, width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          FadeAnimation(
                            3,
                            TextFormField(
                              obscureText: true,
                              keyboardType: TextInputType.text,
                              validator: (oge) {
                                return oge.length >= 6
                                    ? null
                                    : "Şifreniz En Az 6 Karakter Olmalı !";
                              },
                              onChanged: (oge) {
                                setState(() {
                                  _sifre = oge;
                                });
                              },
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.lock_outline,
                                  color: Colors.blue,
                                ),
                                hintText: "Şifre Girin",
                                labelText: "Şifre",
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blue[700], width: 2.0),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.lightBlue, width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          FadeAnimation(
                            4,
                            Container(
                              height: 50,
                              child: RaisedButton(
                                textColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(80.0)),
                                padding: EdgeInsets.all(0.0),
                                child: Ink(
                                  decoration: BoxDecoration(
                                    gradient:
                                        LinearGradient(colors: signInGradients),
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  child: Container(
                                    constraints: BoxConstraints(
                                        maxWidth: double.infinity,
                                        minHeight: 50.0),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Giriş Yap",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  girisYap();
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          FadeAnimation(
                            4,
                            Container(
                              height: 50,
                              child: RaisedButton(
                                textColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(80.0)),
                                padding: EdgeInsets.all(0.0),
                                child: Ink(
                                  decoration: BoxDecoration(
                                    gradient:
                                        LinearGradient(colors: signUpGradients),
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  child: Container(
                                    constraints: BoxConstraints(
                                        maxWidth: double.infinity,
                                        minHeight: 50.0),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Kayıt Ol",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => KayitEkrani()));
                                },
                              ),
                            ),
                          ), SizedBox(
                            height: 20,
                          ),
                          FadeAnimation(
                            5,
                            Container(
                              alignment: Alignment.center,
                              child: GestureDetector(
                                onTap: () {
                                  //Kayıt sayfasına yönlendirir
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => KayitEkrani()));
                                },
                                child: Text(
                                  "Şifreni Hatırlamıyor Musun ?",
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  void girisYap() {
    if (_formAnahtari.currentState.validate()) {
      setState(() {
        yuklenmeDurumu = true;
      });

      //firebase giriş
      FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email, password: _sifre)
          .then((user) {
        setState(() {
          yuklenmeDurumu = false;
        });
        Fluttertoast.showToast(
            msg: "Giriş Başarılı",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => Anasayfa()),
            (Route<dynamic> route) => false);
      }).catchError((onError) {
        //Hata durumu
        setState(() {
          yuklenmeDurumu = false;
        });
        Fluttertoast.showToast(msg: "Hata : " + onError.toString());
      });
    }
  }
}
