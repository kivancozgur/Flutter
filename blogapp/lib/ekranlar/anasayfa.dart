import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'gonderiekle.dart';

class Anasayfa extends StatefulWidget {
  @override
  _AnasayfaState createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  //Gonderi Listesi Widget veritabanından alma
  Widget gonderiListesi() {
    return SingleChildScrollView(
      child: Column(
        children: [
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("Gonderiler")
                  .snapshots(),
              builder: (context, veriler) {
                if (veriler.hasData) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: veriler.data.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot dokumanVerisi =
                            veriler.data.docs[index];
                        return GonderiGosterme(
                            resimURL: dokumanVerisi.data()["resimUrl"],
                            baslik: dokumanVerisi.data()["baslik"],
                            tanimlama: dokumanVerisi.data()["tanimlama"],
                            yazar: dokumanVerisi.data()['yazarAdi']);
                      });
                } else {
                  Container(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  );
                }
              })
        ],
      ),
    );
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
              style: TextStyle(
                fontSize: 26,
              ),
            ),
            Text(
              "Blog",
              style: TextStyle(fontSize: 26, color: Colors.red),
            ),
          ],
        ),
      ),
      body: gonderiListesi(),
      floatingActionButton: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => GonderiEkle()));
              },
              child: Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}

//Gönderileri Gösterme Widgetı
class GonderiGosterme extends StatelessWidget {
  String resimURL, baslik, yazar, tanimlama;
  GonderiGosterme(
      {@required this.resimURL,
      @required this.baslik,
      @required this.tanimlama,
      @required this.yazar});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 12),
      child: Stack(
        children: [
          ClipRRect(
            child: Image.network(
              resimURL,
              width: MediaQuery.of(context).size.width,
              height: 200,
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          Container(
            height: 200,
            decoration: BoxDecoration(
                color: Colors.black54.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8)),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  baslik,
                  style: TextStyle(fontSize: 30),
                ),
                Text(
                  tanimlama,
                  style: TextStyle(fontSize: 30),
                ),
                Text(
                  yazar,
                  style: TextStyle(fontSize: 30),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
