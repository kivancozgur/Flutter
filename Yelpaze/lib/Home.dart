import 'package:flutter/material.dart';
import 'Cardlar.dart' as cardlar;
class Home extends StatefulWidget {
  
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // int seciliSayfa=0;
  // void sayfaDegistir(int index){
  //   setState((){
  //   seciliSayfa=index;
  // });
  // }
  // Widget sayfaGoster(int seciliSayfa){
  //   if(seciliSayfa==0){
  //     return sayfa1();
  //   }
  //   else if(seciliSayfa==1){
  //     return sayfa2();
  //   }
  // }
  // Widget sayfa1(){
  //   return Container(
  //     child: Center(child: Text("SAYFA1"),),
  //   );
  // }
  // Widget sayfa2(){
  //   return Container(
  //     child: Center(child: Text("SAYFA2"),),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return new Container();
  }
}

class HomePage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent ,
          
           actions: <Widget>[
                  new IconButton(icon: new Icon(Icons.search),
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
          title: Text('Yelpaze'),  
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
                    ]),
            
       
              ),        
            ),      
        ),
      
        body: new cardlar.Cardlar(
          
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
            icon: Icon(Icons.grade,color: Colors.white,),
            title: Text('', style: TextStyle(fontSize: 0),),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_comment,color:Colors.white,),
            title: Text('', style: TextStyle(fontSize: 0),),
          ),
         
        ],
    
      ),
    
        ),
    
    )
    ); 
  }
}