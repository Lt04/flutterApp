import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Ontap extends StatefulWidget{
  String title;

  Ontap({this.title});

  @override
  OntapState createState() => OntapState();

}

class OntapState extends State<Ontap>{
  TextEditingController textController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  String message = "";

  @override
  Widget build(BuildContext context){
   return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Container(
        child: Column(
          children: <Widget>[
            Text("New description:"),
            TextField(controller: textController),
            FlatButton(
              color: Colors.green,
              child: Text("Confirm change"),
              onPressed: () async{
                var myjson = {'title': textController.text};
                String newjson = jsonEncode(myjson);
                var response = await http.put('https://jsonplaceholder.typicode.com/albums/' + widget.title, body: newjson, headers: {"Content-type": "application/json; charset=UTF-8"});
                setState(() {
                   message = "The element number " + Album.fromJson(json.decode(response.body)).id.toString() + " has been changed."; 
                });
              }
            ),
            Text(message)
          ],
        )
      )
    );
  }
}

class Album {
  final int userId;
  final int id;
  final String title;

  Album._({this.userId, this.id, this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return new Album._(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}