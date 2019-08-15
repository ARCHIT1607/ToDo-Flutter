import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'todo_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

bool showSpinner=false;
final _auth =FirebaseAuth.instance;
String email;
String password;
final messageTextController1 = TextEditingController();
final messageTextController2 = TextEditingController();


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Login',
                    style: TextStyle(
                        fontSize: 25.0
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    width: 300.0,
                    child: TextField(
                      controller: messageTextController1,
                      onChanged: (value){
                        email=value;
                      },
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: 'Enter your email',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    width: 300.0,
                    child: TextField(
                      controller: messageTextController2,
                      onChanged: (value){
                        password=value;
                      },
                      obscureText: true,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: 'Enter your password',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Material(
                    elevation: 5.0,
                    color: Colors.greenAccent,
                    borderRadius: BorderRadius.circular(30.0),
                    child: MaterialButton(
                      onPressed:()async{

                        setState((){
                          showSpinner=true;
                        });

                        try{
                          final user =  await _auth.signInWithEmailAndPassword(email: email, password: password);
                          if(user!=null){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ToDo()));
                            messageTextController1.clear();
                            messageTextController2.clear();
                          }
                          setState(() {
                            showSpinner=false;
                          });

                        }
                        catch(e){
                          print(e);
                        }

                      },
                      child: Text('Login',style: TextStyle(color: Colors.black),),
                    ),
                  )
                ],
              ),
            )
        ),
      ),
    );
  }
}
