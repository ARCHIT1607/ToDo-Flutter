import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _auth =FirebaseAuth.instance;
final _fireStore = Firestore.instance;
FirebaseUser loggedUser;


class ToDo extends StatefulWidget {
  @override
  _ToDoState createState() => _ToDoState();
}

class _ToDoState extends State<ToDo> {
  String taskTitle;
  String taskDesc;
  final messageTextController1 = TextEditingController();
  final messageTextController2 = TextEditingController();
  bool _validate =false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }


  void getCurrentUser() async{
    try{
      final user = await _auth.currentUser();
      if(user!=null){
        loggedUser = user;
      }
    }
    catch(e){
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('ToDo')),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: (){
              _auth.signOut();
              Navigator.pop(context);
            }),
      ),
      body: SafeArea(
          child:Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                        child:TextField(
                          controller: messageTextController1,
                          onChanged: (value){
                            taskTitle = value;
                          },
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            hintText: 'Enter your title',
                            errorText: _validate?'Value Can\'t Be Empty':null,
                          ),
                        ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      flex: 3,
                      child:TextField(
                        controller: messageTextController2,
                        onChanged: (value){
                          taskDesc = value;
                        },
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: 'Enter your task ',
                          errorText: _validate?'Value Can\'t Be Empty':null,
                        ),
                      ),
                    ),
                    Expanded(
                        child: FlatButton(
                            onPressed: (){
                              setState(() {
                                messageTextController1.text.isEmpty ? _validate = true : _validate = false;
                                messageTextController2.text.isEmpty ? _validate = true : _validate = false;
                              });
                            if(_validate==false){
                              _fireStore.collection('ToDo').document().setData({
                                'taskTitle':taskTitle,
                                'taskDesc':taskDesc,
                                'sender':loggedUser.email,
                              });
                              messageTextController1.clear();
                              messageTextController2.clear();
                            }
                            else{
                              return null;
                            }
                            },
                            child: Icon(Icons.add),
                        ),
                    ),
                  ],
                ),
                ToDoList(),
              ],
            ),
          ) ),
    );
  }
}

class ToDoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _fireStore.collection('ToDo').snapshots(),
      builder: (context,snapshot){
        if(!snapshot.hasData){
          return Center(child: Text('Loading'),);
        }
        return Expanded(
            child:Container(
              child: ListView(
                reverse: true,
                children:snapshot.data.documents.reversed.map((document){
                  if(loggedUser.email==document['sender']){
                    return ListTile(
                      title: Text(document['taskTitle']),
                      subtitle: Text(document['taskDesc']),
                      trailing: IconButton(
                          icon: Icon(Icons.close),
                          onPressed:()async{
                            if(loggedUser.email==document['sender']){
                              _fireStore.collection('ToDo').document(document.documentID).delete();
                            }
                          }
                      ),
                    );
                  }
                  return Visibility(visible: false,child: Text(''));
                }).toList(),
              ),
            )
        );
      },
    );
  }
}

