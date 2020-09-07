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
      backgroundColor: Colors.grey[300],
      body: yuklenmeDurumu
          ? Center(child: CircularProgressIndicator())
          : Container(
              margin: EdgeInsets.only(top: 10),
              alignment: Alignment.center,
              child: Form(
                key: _formAnahtari,
                child: Container(
                  margin: EdgeInsets.all(16),
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
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          validator: (oge) {
                            return oge.contains("@")
                                ? null
                                : "Geçerli Email Adresi Girin !";
                          },
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.mail_outline,
                              color: Colors.blue,
                            ),
                            hintText: "E-mail Adresi Girin",
                            labelText: "E-mail",
                            prefixText: ' ',
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
                            prefixIcon: const Icon(
                              Icons.lock_outline,
                              color: Colors.blue,
                            ),
                            hintText: "Şifre Girin",
                            labelText: "Şifre",
                            prefixText: ' ',
                            helperText: 'Şifreniz En Az 6 Karakter Olmalı',
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
                                    maxWidth: double.infinity, minHeight: 50.0),
                                alignment: Alignment.center,
                                child: Text(
                                  "Kayıt Ol",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
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
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          alignment: Alignment.center,
                        ),
                      ],
                    ),
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

List<Color> signUpGradients = [
  Color(0xFFFF9945),
  Color(0xFFFc6076),
];
List<Color> signInGradients = [
  Color(0xFF0EDED2),
  Color(0xFF03A0FE),
];
