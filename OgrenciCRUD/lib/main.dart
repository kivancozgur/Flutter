import 'package:flutter/material.dart';
import 'package:pratik/screens/students_add.dart';
import 'models/student.dart';
void main()=>runApp(MyApp());

final Color darkBlue=Color.fromARGB(255, 18, 32, 47);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: darkBlue),
      home:HomeScreen()
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState(){
    return _HomeScreenState();
    }
}

class _HomeScreenState extends State {
    List<Student> students=[
    Student.withId(1,"Kıvanç","Özgür",30),
    Student.withId(2,"Burak","Even",90),
    Student.withId(3,"Okan","Torun",85),
    Student.withId(4,"Ramazan","Yılmaz",40)
  ];

 Student selectedStudent=Student.withId(0, "", "", 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(),
      appBar: AppBar(
        title: Text("Öğrenci Takip Sistemi")
        ),
    );
  }
  Widget buildBody(){
    return Column(
      children:<Widget>[
        Expanded(
                  child: ListView.builder(
            itemCount: students.length,
            itemBuilder: (BuildContext context, int index){
              return ListTile(
                title:Text(students[index].firstName+" "+students[index].lastName),
                subtitle: Text("Not : "+students[index].grade.toString()+" ["+students[index].getStatus+"]"),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage("https://avatars3.githubusercontent.com/u/34067601?v=4"),
                ),
                trailing: buildStatusIcon(students[index].grade),
                onTap: (){
                  setState(() {
                    this.selectedStudent=students[index];
                  });
                  
                  print(this.selectedStudent.firstName);
                },
                onLongPress: (){
                  print("Uzun basıldı");
                },
                            );
                            }
                          ),
                        ),
                        Text("Seçili Öğrenci : "+selectedStudent.firstName),
                        Row(
                          children: <Widget>[
                            Flexible(
                              fit: FlexFit.tight,
                              flex: 2,
                              child: RaisedButton(
                                color: Colors.green,
                                child: Row(
                                  children: [
                                    Icon(Icons.add),
                                    SizedBox(width:5.0),
                                    Text("Yeni Öğrenci")
                                  ],
                                ),
                                onPressed: (){
                                  Navigator.push(context,MaterialPageRoute(builder: (context)=>StudentAdd(students)));
                                  print(students);
                                }
                                ),
                              ),
                               Flexible(
                              fit: FlexFit.tight,
                              flex: 2,
                              child: RaisedButton(
                                color: Colors.grey,
                                child: Row(
                                  children: [
                                    Icon(Icons.add),
                                    SizedBox(width:5.0),
                                    Text("Güncelle")
                                  ],
                                ),
                                onPressed: (){
                                  print("Güncelle");
                                }
                                ),
                              ),
                               Flexible(
                              fit: FlexFit.tight,
                              flex: 1,
                              child: RaisedButton(
                                color: Colors.red,
                                child: Row(
                                  children: [
                                    Icon(Icons.add),
                                    SizedBox(width:5.0),
                                    Text("Sil")
                                  ],
                                ),
                                onPressed: (){
                                  print("Sil");
                                }
                                ),
                              ),
                          ],
                        )
                      ]
                    );
                  }
                
                  Widget buildStatusIcon(int grade) {
                        if(grade>=50) return Icon(Icons.done);
                        else if(grade>=40) return Icon(Icons.album);
                        else return Icon(Icons.clear);
                  }
}