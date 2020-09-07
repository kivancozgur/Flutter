import 'package:flutter/material.dart';

import 'Cardlar.dart';

class Indirilenler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("İndirilenler"),
      ),
      body: Cardlar(),
    );
  }
}
