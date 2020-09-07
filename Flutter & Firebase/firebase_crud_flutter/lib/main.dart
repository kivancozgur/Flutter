import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.orange,
      accentColor: Colors.cyan,
    ),
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String ad, id, kategori;
  double fiyat;

  urunAdiAl(urunAdi) => this.ad = urunAdi;
  urunIDAl(urunID) => this.id = urunID;
  urunKategorisiAl(urunKategorisi) => this.kategori = urunKategorisi;
  urunFiyatiAl(urunFiyati) => this.fiyat = double.parse(urunFiyati);

  veriEkle() {
    DocumentReference veriYolu =
        Firestore.instance.collection("Urunler").document(ad);
    Map<String, dynamic> urunler = {
      "urunAdi": ad,
      "urunID": id,
      "urunKategorisi": kategori,
      "urunFiyati": fiyat,
    };
    veriYolu.setData(urunler).whenComplete(() {
      print(ad + " eklendi");
    });
  }

  veriOku() {
    DocumentReference veriYolu =
        Firestore.instance.collection("Urunler").document(ad);
    veriYolu.get().then((alinanVeri) {
      print(alinanVeri.data["urunAdi"]);
      print(alinanVeri.data["urunID"]);
      print(alinanVeri.data["urunKategorisi"]);
      print(alinanVeri.data["urunFiyati"]);
    });
    print("okundu");
  }

  veriGuncelle() {
    DocumentReference veriYolu =
        Firestore.instance.collection("Urunler").document(ad);
    Map<String, dynamic> urunGuncelVeri = {
      "urunAdi": ad,
      "urunID": id,
      "urunKategorisi": kategori,
      "urunFiyati": fiyat,
    };
    veriYolu.updateData(urunGuncelVeri).whenComplete(() {
      print(ad + " Guncellendi");
    });
  }

  veriSil() {
    DocumentReference veriYolu =
        Firestore.instance.collection("Urunler").document(ad);
    veriYolu.delete().whenComplete(() {
      print(ad + " Silindi");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Ürün Envanteri",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Ürün Adı : ",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.deepOrange, width: 2.0),
                    ),
                  ),
                  onChanged: (String urunAdi) => urunAdiAl(urunAdi)),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Ürün ID : ",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.deepOrange, width: 2.0),
                  ),
                ),
                onChanged: (String urunID) => urunIDAl(urunID),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Ürün Kategorisi : ",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.deepOrange, width: 2.0),
                    ),
                  ),
                  onChanged: (String urunKategorisi) =>
                      urunKategorisiAl(urunKategorisi)),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Ürün Fiyati : ",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.deepOrange, width: 2.0),
                    ),
                  ),
                  onChanged: (String urunFiyati) => urunFiyatiAl(urunFiyati)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                      color: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text("Ekle"),
                      textColor: Colors.white,
                      onPressed: () => veriEkle()),
                  // RaisedButton(
                  //     color: Colors.cyan,
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(16),
                  //     ),
                  //     child: Text("Oku"),
                  //     textColor: Colors.white,
                  //     onPressed: () => veriOku()),
                  RaisedButton(
                      color: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text("Güncelle"),
                      textColor: Colors.white,
                      onPressed: () => veriGuncelle()),
                  RaisedButton(
                      color: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text("Sil"),
                      textColor: Colors.white,
                      onPressed: () => veriSil()),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text("Ürün Adı"),
                  ),
                  Expanded(
                    child: Text("Ürün ID"),
                  ),
                  Expanded(
                    child: Text("Ürün Kategorisi"),
                  ),
                  Expanded(
                    child: Text("Ürün Fiyatı"),
                  ),
                ],
              ),
            ),
            StreamBuilder(
              stream: Firestore.instance.collection("Urunler").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot dokumanSnapshot =
                            snapshot.data.documents[index];
                        return Row(
                          children: [
                            Expanded(
                              child: Text(dokumanSnapshot["urunAdi"]),
                            ),
                            Expanded(
                              child: Text(dokumanSnapshot["urunID"]),
                            ),
                            Expanded(
                              child: Text(
                                  dokumanSnapshot["urunFiyati"].toString()),
                            ),
                            Expanded(
                              child: Text(
                                  dokumanSnapshot["urunKategorisi"]),
                            ),
                          ],
                        );
                      });
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
