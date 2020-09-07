import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TopluTasima extends StatefulWidget {
  @override
  _TopluTasimaState createState() => _TopluTasimaState();
}

class _TopluTasimaState extends State<TopluTasima> {
  @override
  Widget build(BuildContext context) {
     return MaterialApp(debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white ,
           actions: <Widget>[
                  new IconButton(icon: new Icon(Icons.filter_list),
              onPressed: (){},
              ),
        ],
        
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        textTheme: TextTheme(
          title: TextStyle(
            fontFamily: 'Pacifico',
            color: Colors.white,
            fontSize: 25.0,
          )
        ),
          title: Text('Toplu Taşıma'),  
          centerTitle: true,
           flexibleSpace: Container(
             decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: const  Radius.circular(18.0),bottomRight: const  Radius.circular(18.0),),
               gradient: LinearGradient(
                 
                 begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                     Color(0xFF8C119A),
                     Color(0xFF6D4DD4),
                     Color(0xFF5779FF),
                  ])        
              ),        
            ),      
        ),
        bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(canvasColor: Color(0xFF5779FF)),
        child: BottomNavigationBar(
        //currentIndex: seciliSayfa,
        //onTap: sayfaDegistir,
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.white,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.grade),
            title: Text('',style: TextStyle(fontSize: 0)),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_comment),
            title: Text('',style: TextStyle(fontSize: 0)),
          ),
         
        ],
    
      ),
    
        ),
    
    )
    ); 
  }
}