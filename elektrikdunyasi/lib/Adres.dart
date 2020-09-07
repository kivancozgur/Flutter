import 'package:flutter/material.dart';

class Adres extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adres"),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Image.network(
                    "https://i.pinimg.com/originals/e2/19/5e/e2195ec452e373faa93426dff23be88a.gif",
                    width: MediaQuery.of(context).size.width,
                  )
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Text(
                    " Adres : ",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Text(
                      "Perpa Ticaret Merkezi A Blok Kat: 11 No:1402",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Text(
                    " Telefon : ",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Text(
                      "	0212 320 77 70",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Text(
                    " Fax : ",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Text(
                      "	0212 320 11 37",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Text(
                    " Mail : ",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Text(
                      "	info@elektrikdunyasi.com.tr",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
