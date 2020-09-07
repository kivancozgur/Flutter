import 'dart:io';
import 'package:blogapp/veritabani/veritabani.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class GonderiEkle extends StatefulWidget {
  @override
  _GonderiEkleState createState() => _GonderiEkleState();
}

class _GonderiEkleState extends State<GonderiEkle> {
  //Progres durum
  bool progresDurumu = false;
  String baslik, tanimlama, yazar;
  File _resim;
  final secici = ImagePicker();
  Future resimAl() async {
    final secilenDosya = await secici.getImage(source: ImageSource.gallery);
    setState(() {
      Fluttertoast.showToast(
        msg: "Resim Başarıyla Eklendi !",
        backgroundColor: Colors.green,
      );
      //Dosya yolunu değişkene aktar.
      _resim = File(secilenDosya.path);
    });
  }

  gonderiYukle() async {
    if (_resim != null) {
      setState(() {
        progresDurumu = true;
      });
      StorageReference depolamaYolu = FirebaseStorage.instance
          .ref()
          .child("blogResimleri")
          .child("${randomAlphaNumeric(9)}");
      StorageUploadTask resimYuklemeGorevi = depolamaYolu.putFile(_resim);
      var resimURL =
          await (await resimYuklemeGorevi.onComplete).ref.getDownloadURL();

      Fluttertoast.showToast(
          msg: "Resim Yüklendi !\nURL : " + resimURL.toString(),
          backgroundColor: Colors.green);
      Map<String, String> gonderiCokluVerisi = {
        "resimUrl": resimURL.toString(),
        "yazarAdi": yazar,
        "baslik": baslik,
        "tanimlama": tanimlama
      };
      // DocumentReference veriYolu =
      //     Firestore.instance.collection("Gonderiler").document();
      // veriYolu.setData(gonderiCokluVerisi);
      VeriTabani veriTabani = new VeriTabani();
      veriTabani.veriEkle(gonderiCokluVerisi).then((sonuc) {
        Navigator.pop(context);
      });
    } else
      Fluttertoast.showToast(msg: "Resim Seçin !", backgroundColor: Colors.red);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Kıvanç",
              style: TextStyle(fontSize: 26),
            ),
            Text(
              "Blog",
              style: TextStyle(fontSize: 26, color: Colors.red),
            ),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: () {
              gonderiYukle();
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.file_upload),
            ),
          ),
        ],
      ),
      body: progresDurumu
          ? Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 12,
                  ),
                  GestureDetector(
                    child: _resim != null
                        ? Container(
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 9),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(18),
                              child: Image.file(
                                _resim,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : Container(
                            margin: EdgeInsets.symmetric(horizontal: 18),
                            height: 170,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.add_a_photo,
                              color: Colors.black54,
                            ),
                          ),
                    onTap: () {
                      resimAl();
                    },
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        TextField(
                          decoration: InputDecoration(
                            hintText: "Başlık Yazın",
                            labelText: "Başlık",
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (oge) {
                            baslik = oge;
                          },
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            hintText: "Tanımlama Yazın",
                            labelText: "Tanımlama",
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (oge) {
                            tanimlama = oge;
                          },
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            hintText: "Yazar Adı Yazın",
                            labelText: "Yazar Adı",
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (oge) {
                            yazar = oge;
                          },
                        ),
                        SizedBox(
                          height: 12,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
