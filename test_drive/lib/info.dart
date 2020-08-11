import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:test_drive/actions.dart';


class Info extends StatefulWidget{
  String model;
  String serial;
  String regions;
  String antennas;
  String power_range;
  String connected;
  String status;

  Info({this.model, this.antennas, this.connected, this.power_range, this.regions, this.serial, this.status});

  @override
  InfoState createState() => InfoState();

}

class InfoState extends State<Info>{

  

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context){
   return Scaffold(
      appBar: AppBar(title: Text("Info")),
      body: ListView(
        children: [
          ListTile(leading: Text("Model:"), title: Text(widget.model),),
          ListTile(leading: Text("Serial:"), title: Text(widget.serial)),
          ListTile(leading: Text("Regions:"), title: Text(widget.regions)),
          ListTile(leading: Text("Antennas:"), title: Text(widget.antennas)),
          ListTile(leading: Text("Power range:"), title: Text(widget.power_range),),
          ListTile(leading: Text("Connected:"), title: Text(widget.connected),),
          ListTile(leading: Text("Status:"), title: Text(widget.status))
      ],)
    );
  }

}
