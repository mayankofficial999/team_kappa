import 'dart:async';
import 'package:flutter/material.dart';
import 'package:team_kappa/PhoneAuth.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:team_kappa/Register.dart';
import 'package:team_kappa/main.dart';

class OTPcheck extends StatefulWidget {
  @override
  _OTPcheckState createState() => _OTPcheckState();
}

class _OTPcheckState extends State<OTPcheck> {
  var hint;
  bool showInputField = false;
  String heading= 'Login Page';
  String buttonText='Login';
  int c=0;
  String pin='';
  final myController3 = TextEditingController();
  bool visible=false;
  void changeProgress() {
    setState(() {
      visible=!visible;
    });
  }
  // final myController4 = TextEditingController();
  void changeInputField() {
    setState(() {
      showInputField=!showInputField;
      if(heading=='Verification')
      heading='Enter OTP';
      if(buttonText=='Get OTP')
      buttonText='Sign In';
    });
  }
  
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    print(showInputField);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      //appBar: AppBar(title: Center(child:Text("Authenticator",style: TextStyle(color: Colors.white,),),),),
      body:
      Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/y1ostvqnr4711.jpg'),
          fit: BoxFit.cover)
        ),
        child: 
        Stack(children:[
        Column(
          children:
        [
          //Title
          Center(child:
          Container(child:
          ClipOval(
          child: Image.asset("assets/otpscreen.jpg"),
          ),
          margin: const EdgeInsets.only(top:120,bottom:50,left: 150,right: 150),
          )
          ),
          Text('$heading',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,)),
          Text(''),
          showInputField? otpbox():phoneNumber(),
          Text(''),
          ElevatedButton(onPressed: () async{
            changeProgress();
            if(showInputField==false)
            {
              await PhoneAuth(myController3.text,pin,context).verifyPhone(0);
            Timer(Duration(seconds: 5),()async{
              changeInputField();
              changeProgress();});
            }
            else
            {
              print("Signing In");
              await PhoneAuth(myController3.text,pin,context).verifyPhone(1);
              Timer(Duration(seconds: 2),()async{
              changeProgress();
              Navigator.push(context,MaterialPageRoute(builder: (context) => Register()),);
              });
            }
          },
            child: Text('      $buttonText      ')),
        ]
        ),
        Center(child:SizedBox(height:100,width: 100,child:
          visible? 
          CircularProgressIndicator(
            backgroundColor: Colors.white,
            valueColor: AlwaysStoppedAnimation(Colors.lightBlue),
            strokeWidth: 10,
            semanticsLabel: 'Loading ...',
          ) 
          :
          Container(),
          ),
          ),
        ]
        ),
      ),
    );
  }

  Widget phoneNumber(){
    return Container(child:
          TextFormField(
              decoration: const InputDecoration(
              icon: Icon(Icons.phone),
              border: OutlineInputBorder(),
              hintText: '+91XXXXXXXXXX',
              labelText: 'Phone Number',
              ),
              controller: myController3,
            ),
            margin: EdgeInsets.only(left: 20,right: 20,top: 10),
          );
  }

  Widget otpbox(){
    return Container(child:
          OTPTextField(
            length: 6,
            width: MediaQuery.of(context).size.width,
            fieldWidth: 25,
            style: TextStyle(
              fontSize: 17
            ),
            textFieldAlignment: MainAxisAlignment.spaceAround,
            fieldStyle: FieldStyle.underline,
            onChanged: (pin1) {
              print("Completed: " + pin1);
              pin=pin1;
            },
            onCompleted: (pin1) async{
              pin=pin1;
              changeProgress();
              print("Signing In");
              await PhoneAuth(myController3.text,pin,context).verifyPhone(1);
              Timer(Duration(seconds: 2),()async{
              changeProgress();
              Navigator.push(context,MaterialPageRoute(builder: (context) => Register()),);
              });
              //Navigator.push(context,MaterialPageRoute(builder: (context) => Register()),);
            }
          ),
          margin: EdgeInsets.only(bottom:30,left:20,right:20),
    );
  }

}