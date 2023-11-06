import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class UpdatePage extends StatefulWidget {
  final DocumentSnapshot<Object> data;
  UpdatePage({ required this.data});


  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  TextEditingController userNameController=TextEditingController();
  TextEditingController userEmailController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update User "),
      ),
      body:  Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: userNameController,
                  decoration: InputDecoration(
                    labelText: widget.data['name'],
                      hintText: widget.data['name']
                  ),
                ),
                TextField(
                  controller: userEmailController,
                  decoration:  InputDecoration(
                      labelText: widget.data['email'],

                      hintText: widget.data['email']
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(onPressed: (){
                  var firestore=FirebaseFirestore.instance;
                  firestore.collection("Users").doc(widget.data.id).update({
                    'name': userNameController.text,
                    'email': userEmailController.text,
                  });
                  SnackBar(content: Text("user Update sucessfully"),);
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage1()));



                }, child: Text("Save"))
              ],
            ),
          )),
    );
  }
}
