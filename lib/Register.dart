import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:team_kappa/Receptionist.dart';


class Register extends StatefulWidget {
  const Register({ Key? key }) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  void logout() async {
    await FirebaseAuth.instance.signOut();
  }
  Map data={};
  var selectedValue="Receptionist";
  final ins=FirebaseDatabase.instance;
  void send(Map s){
    final refer=ins.reference();
    var loc=
    refer
    .child('reception')
    .child('${FirebaseAuth.instance.currentUser!.uid}');
    loc.set(s);
  }
  void checkReg(){
    final refer=ins.reference();
    refer.child('reception').orderByKey().equalTo('${FirebaseAuth.instance.currentUser!.uid}').once().then(
      (x) { 
        print(x.exists);
        if(x.exists)
        Navigator.push(context,MaterialPageRoute(builder: (context) => HomePage()),);
      });
  }
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("Receptionist"),value: "Receptionist"),
    DropdownMenuItem(child: Text("Junior Doctor"),value: "Junior Doctor"),
    DropdownMenuItem(child: Text("Senior Doctor"),value: "Senior Doctor"),
    DropdownMenuItem(child: Text("Medical Store"),value: "Medical Store"),
  ];
  TextEditingController _name= new TextEditingController();
  TextEditingController _age= new TextEditingController();
  TextEditingController _gender= new TextEditingController();
  TextEditingController _mobno= new TextEditingController();
  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    checkReg();
    Timer(Duration(seconds: 5), (){});
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Center(child:Text("MedHub",style: TextStyle(color: Colors.white,),),),),
      body:Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/y1ostvqnr4711.jpg'),
          fit: BoxFit.cover)
        ),
      child: 
      Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 80,),
        Center(child:
        Text("Select User Type",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800]
          ),
          )
        ),
        SizedBox(height: 80,),
        Container(
        child:
          DropdownButton(
            value: selectedValue,
            icon: Icon(Icons.verified),
            dropdownColor: Colors.grey[500],
            onChanged: (String? newValue){
              setState(() {
                selectedValue = newValue!;
              });
            },
            items: menuItems
          )
        ),
        SizedBox(height: 50,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(width: 10,),
                Text("Name: ",style: TextStyle(fontSize: 16,color: Colors.black),),
                Container(
                margin: EdgeInsets.only(top:0),
                height: 60,
                width: 80,
                child: 
                  TextFormField(
                    style: TextStyle(color: Colors.black,fontSize: 16),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    controller: _name,
                    //initialValue: "${widget.data['$patientNo'][1]}",
                    decoration: InputDecoration(
                    enabledBorder: const UnderlineInputBorder(borderSide: const BorderSide(color: Colors.black, width: 0.0),),
                    hintText: '',
                    hintStyle: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    onChanged: (s){
                      String name=s;
                    },
                  ),
                ),
              ]
            ),
          SizedBox(width: 10,),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Age: ",style: TextStyle(fontSize: 16,color: Colors.black),),
                Container(
                margin: EdgeInsets.only(top:0),
                height: 60,
                width: 80,
                child: 
                  TextFormField(
                    style: TextStyle(color: Colors.black,fontSize: 16),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    controller: _age,
                    //initialValue: "${widget.data['$patientNo'][1]}",
                    decoration: InputDecoration(
                    enabledBorder: const UnderlineInputBorder(borderSide: const BorderSide(color: Colors.black, width: 0.0),),
                    hintText: '',
                    hintStyle: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    onChanged: (s){
                      String age=s;
                    },
                  ),
                ),
              ]
            ),
        ],),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(width: 10,),
                Text("Gender: ",style: TextStyle(fontSize: 16,color: Colors.black),),
                Container(
                margin: EdgeInsets.only(top:0),
                height: 60,
                width: 80,
                child: 
                  TextFormField(
                    style: TextStyle(color: Colors.black,fontSize: 16),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    controller: _gender,
                    //initialValue: "${widget.data['$patientNo'][1]}",
                    decoration: InputDecoration(
                    enabledBorder: const UnderlineInputBorder(borderSide: const BorderSide(color: Colors.black, width: 0.0),),
                    hintText: '',
                    hintStyle: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    onChanged: (s){
                      String gender=s;
                    },
                  ),
                ),
              ]
            ),
          SizedBox(width: 10,),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Mobile No: ",style: TextStyle(fontSize: 16,color: Colors.black),),
                Container(
                margin: EdgeInsets.only(top:0),
                height: 60,
                width: 80,
                child: 
                  TextFormField(
                    style: TextStyle(color: Colors.black,fontSize: 16),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    controller: _mobno,
                    //initialValue: "${widget.data['$patientNo'][1]}",
                    decoration: InputDecoration(
                    enabledBorder: const UnderlineInputBorder(borderSide: const BorderSide(color: Colors.black, width: 0.0),),
                    hintText: '',
                    hintStyle: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    onChanged: (s){
                      String mobno=s;
                    },
                  ),
                ),
              ]
            ),
        ],)
        ,SizedBox(height: 20,),
        ElevatedButton(
          onPressed: (){
            send({
            'name':'${_name.text}',
            'mobile_no':'${_mobno.text}',
            'age':'${_age.text}',
            'gender':'${_gender.text}'
            });
            Navigator.push(context,MaterialPageRoute(builder: (context) => HomePage()),);
          },
          child: Text("Submit")
        )
      ],
    )
    )
    )
    );
  }
}