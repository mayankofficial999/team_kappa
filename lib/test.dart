import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:team_kappa/main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      //appBar: AppBar(title: Center(child:Text("MedHub",style: TextStyle(color: Colors.white,),),),automaticallyImplyLeading: false,),
      body:
      Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/y1ostvqnr4711.jpg'),
          fit: BoxFit.cover)
        ),
      child:
        Container(
          child: 
          Center(child: ElevatedButton(
            child: Text("Log out"),
            onPressed: () async {
              await Firebase.initializeApp();
              await FirebaseAuth.instance.signOut();
              Navigator.push(context,MaterialPageRoute(builder: (context) => MyApp()),);
              },
            ),
          ),
        )
      )
    );
  }
}