import 'package:elektrikdunyasi/Cardlar.dart';
import 'package:flutter/material.dart';

class Dergiler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dergiler"),
      ),
      body: Cardlar(),
    );
  }
}
