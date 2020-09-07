import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Kuafor extends StatefulWidget {
  @override
  _KuaforState createState() => _KuaforState();
}

class _KuaforState extends State<Kuafor> {
final List<String> entries = <String>['Siesta', 'GU&ES', 'Mehdi Toprak'];
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
          title: Text('Kuaför'),  
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

        body: ListView.builder(
        padding: const EdgeInsets.all(15),
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 75,
            margin: EdgeInsets.only(top: 15),
            color: Color(0xFF6D4DD4),
            child: Center(
              child: Text(
                '${entries[index]}',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  color: Colors.white,
                  fontSize: 20.0,
              ),
              )
            ),
          );
        }
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
            title: Text('',style: TextStyle(fontSize: 0),),
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