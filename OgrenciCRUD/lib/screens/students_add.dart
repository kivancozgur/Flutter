import 'package:flutter/material.dart';
import 'package:pratik/models/student.dart';
//import 'package:pratik/models/student.dart';

class StudentAdd extends StatefulWidget {
 List<Student> students;
 StudentAdd(this.students);
  @override
  State<StatefulWidget> createState() {
    return _StudentAddState();
  }
}

class _StudentAddState extends State<StudentAdd> {  
  var formKey=GlobalKey<FormState>();
  Student student=Student("", "", 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Yeni Öğrenci Ekle"),
      ),
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
                child: Column(
                  children:<Widget> [
                    buildFirstNameField(),
                    buildLastNameField(),
                    buildGradeField(),
                    buildSubmitButtonField()
                                      ],
                                    ),),
                          ),
                        );
                      }
                    
                      Widget buildFirstNameField() {
                        return TextFormField(
                          decoration:InputDecoration(labelText: "Öğrenci Adı",hintText: "Kıvanç") ,
                          onSaved: (String value){
                            student.firstName=value;
                          },
                        );
                      }
                       Widget buildLastNameField() {
                        return TextFormField(
                          decoration:InputDecoration(labelText: "Öğrenci Soyadı",hintText: "Özgür") ,
                          onSaved: (String value){
                            student.lastName=value;
                          },
                        );
                      }
                       Widget buildGradeField() {
                        return TextFormField(
                          decoration:InputDecoration(labelText: "Aldığı Not",hintText: "65") ,
                          onSaved: (String value){
                            student.grade=int.parse(value);
                          },
                        );
                      }
                       Widget buildSubmitButtonField() {
                        return RaisedButton(
                          child:Text("Kaydet"),
                          onPressed: (){
                            formKey.currentState.save();
                            widget.students.add(student);
                            Navigator.pop(context);
                          },
                        );
                      }
}