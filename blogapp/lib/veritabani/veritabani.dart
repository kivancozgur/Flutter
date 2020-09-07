import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class VeriTabani {
  //Veri ekleme metodu
  Future<void> veriEkle(blogVerisi) async {
    FirebaseFirestore.instance
        .collection("Gonderiler")
        .add(blogVerisi)
        .catchError((hata) {
      Fluttertoast.showToast(
          msg: "Hata : " + hata.toString(), backgroundColor: Colors.red);
    });
  }
}
