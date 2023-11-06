import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
Future getData() async{
  var firestore=FirebaseFirestore.instance;
  QuerySnapshot qs=await firestore.collection('Students').get();
  return qs.docs;
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase Example"),

      ),
      body: Center(
        child: FutureBuilder(
          future: getData(),
          builder: (_,snampshot){

            return (snampshot.connectionState==ConnectionState.waiting)?CircularProgressIndicator():ListView.builder(
                itemCount: snampshot.data.length,
                itemBuilder: (_,index){
                  DocumentSnapshot data=snampshot.data[index];
                  return Card(
                    child: ListTile(
                      title: Text(data['name']),
                    ),
                  );
                });
          },
        ),

      ),

    );
  }
}
