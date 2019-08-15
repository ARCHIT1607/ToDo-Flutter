import 'package:flutter/material.dart';
import 'registration_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  static const id = 'HomeScreen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Material(
                  elevation: 5.0,
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.circular(30.0),
                  child: MaterialButton(
                    minWidth: 350.0,
                    onPressed:(){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>RegistrationScreen()));
                    },
                    child: Text('Register',style: TextStyle(color: Colors.black,fontSize: 25.0),),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Material(
                  elevation: 5.0,
                  color: Colors.lightGreenAccent,
                  borderRadius: BorderRadius.circular(30.0),
                  child: MaterialButton(
                    onPressed:(){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                    },
                    minWidth: 350.0,
                    child: Text('Login',style: TextStyle(color: Colors.black,fontSize: 25.0),),
                  ),
                )
              ],
            ),
          )) ,
    );
  }
}
