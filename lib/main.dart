import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:team_kappa/Login.dart';
import 'package:team_kappa/Receptionist.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays(
      [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  var logedIn=false;
  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if(user!=null)
      logedIn=true;
     });
    if(FirebaseAuth.instance.currentUser!=null)
    logedIn=true;
    else
    logedIn=false;
    print(FirebaseAuth.instance.currentUser);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
      resizeToAvoidBottomInset: false,
      //appBar: AppBar(title: Center(child:Text("MedHub",style: TextStyle(color: Colors.white,),),),),
      body: logedIn? HomePage():OTPcheck()
      )
      // Container(
      //   constraints: BoxConstraints.expand(),
      //   decoration: BoxDecoration(
      //   image: DecorationImage(
      //     image: AssetImage('assets/y1ostvqnr4711.jpg'),
      //     fit: BoxFit.cover)
      //   ),
      //   child:Register(),),)
    );
  }
}