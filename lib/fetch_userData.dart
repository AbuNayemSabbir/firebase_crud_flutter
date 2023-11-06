import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_example/update_page.dart';
import 'package:flutter/material.dart';

class DisplayUserData extends StatefulWidget {
  const DisplayUserData({Key? key}) : super(key: key);

  @override
  State<DisplayUserData> createState() => _DisplayUserDataState();
}

class _DisplayUserDataState extends State<DisplayUserData> {

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: const Text("User Information Example"),

      ),
      body: Center(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Users").snapshots(),
          builder: (_,snampshot){

            return (snampshot.connectionState==ConnectionState.waiting)?CircularProgressIndicator():ListView.builder(
                itemCount: snampshot.data!.docs.length,
                itemBuilder: (_,index){
                  var data=snampshot.data!.docs[index];
                  return Card(
                    child: ListTile(
                      title: Text(data['name'],style: TextStyle(fontWeight: FontWeight.bold),),
                      subtitle: Text(data['email']),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdatePage(data: data,)));

                          }, icon:Icon(Icons.edit)),
                          IconButton(onPressed: (){
                            var firestore=FirebaseFirestore.instance;
                            firestore.collection("Users").doc(data.id).delete();
                          }, icon:Icon(Icons.delete)),
                        ],
                      ),
                    ),
                  );
                });
          },
        ),

      ),

    );

  }
}
