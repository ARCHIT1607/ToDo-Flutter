import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';


final _auth = FirebaseAuth.instance;
bool showSpinner=false;


class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String email;
  String password;

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
                  Text('Register',
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
                        setState(() {
                          showSpinner=true;
                        });
                        try{
                          final user =  await _auth.createUserWithEmailAndPassword(email: email, password: password);
                          if(user!=null){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                            setState(() {
                              showSpinner=false;
                            });
                          }
                          else{
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                          }
                        }
                        catch(e){
                          print(e);
                        }

                      },
                      child: Text('Register',style: TextStyle(color: Colors.black),),
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
