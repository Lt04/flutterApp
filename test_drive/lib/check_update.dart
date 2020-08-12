import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CheckUpdate extends StatefulWidget{
  String version;
  List<dynamic> versions;
  String status;

  CheckUpdate({this.version, this.versions, this.status});

  @override
  CheckUpdateState createState() => CheckUpdateState();

}

class CheckUpdateState extends State<CheckUpdate>{

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context){
   return Scaffold(
      appBar: AppBar(title: Text("Available updates")),
      body: ListView.builder(
        itemBuilder: (context, i){
          if(widget.versions.length > i){
            return ListTile(
              title: Text(widget.versions[i])
            );
          }
        }
      )
    );
  }

}