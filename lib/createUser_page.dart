import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_example/home_page.dart';
import 'package:flutter/material.dart';

class CreateUserPage extends StatefulWidget {
  const CreateUserPage({Key? key}) : super(key: key);

  @override
  State<CreateUserPage> createState() => _CreateUserPageState();
}

class _CreateUserPageState extends State<CreateUserPage> {
  TextEditingController userNameController=TextEditingController();
  TextEditingController userEmailController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create User "),
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
                    hintText: 'Enter your name'
                  ),
                ),
                TextField(
                  controller: userEmailController,
                  decoration: const InputDecoration(
                    hintText: 'Enter your email'
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(onPressed: (){
                  var firestore=FirebaseFirestore.instance;
                  firestore.collection("Users").add({
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
