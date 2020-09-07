import 'package:flutter/material.dart';
import 'package:yelpaze/Restoran.dart';
import 'Home.dart';

void main() { 
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/":(context)=>HomePage(),
        "/Restoran":(context)=>Restoran(),
      },
    ),
  );
}
