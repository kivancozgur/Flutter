import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loginfirebase/ekranlar/anasayfa.dart';
import 'package:loginfirebase/ekranlar/kayitekrani.dart';

class GirisSayfasi extends StatefulWidget {
  @override
  _GirisSayfasiState createState() => _GirisSayfasiState();
}

class _GirisSayfasiState extends State<GirisSayfasi> {
  //DEĞİŞKENLER
  String _email, _sifre;
  bool yuklenmeDurumu = false;
  var _formAnahtari = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Giriş Ekranı"),
      ),
      body: yuklenmeDurumu
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              margin: EdgeInsets.all(16),
              alignment: Alignment.center,
              child: Form(
                key: _formAnahtari,
                child: Center(
                  child: Container(
                    margin: EdgeInsets.all(16),
                    alignment: Alignment.center,
                    child: Column(
                      children: [
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
                          onChanged: (oge) {
                            setState(() {
                              _email = oge;
                            });
                          },
                          decoration: InputDecoration(
                              hintText: "E-mail Girin",
                              labelText: "E-mail",
                              border: OutlineInputBorder()),
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
                          onChanged: (oge) {
                            setState(() {
                              _sifre = oge;
                            });
                          },
                          decoration: InputDecoration(
                              hintText: "Şifre Girin",
                              labelText: "Şifre",
                              border: OutlineInputBorder()),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: double.infinity,
                          height: 50,
                          child: RaisedButton(
                            textColor: Colors.white,
                            color: Colors.blue,
                            child: Text(
                              "Giriş Yap",
                              style: TextStyle(fontSize: 18),
                            ),
                            onPressed: () {
                              girisYap();
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
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
                              "Henüz Hesabınız Yok Mu?",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ],
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
