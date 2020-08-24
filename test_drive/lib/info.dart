import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

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
   String printAntennas = "";
   for(int i = 0; i < widget.antennas.length; i++){
     if(widget.antennas[i] != '[' && widget.antennas[i] != ']'){
       printAntennas += widget.antennas[i];
     }
   }
   String printRegions = "";
   for(int i = 0; i < widget.regions.length; i++){
     if(widget.regions[i] != '[' && widget.regions[i] != ']' && widget.regions[i] != '"'){
       printRegions += widget.regions[i];
     }
   }
   return Scaffold(
      appBar: AppBar(title: Text("Info")),
      body: ListView(
        children: [
          ListTile(leading: Text("Model:"), title: Text(widget.model),),
          ListTile(leading: Text("Serial:"), title: Text(widget.serial)),
          ListTile(leading: Text("Regions:"), title: Text(printRegions)),
          ListTile(leading: Text("Antennas:"), title: Text(printAntennas)),
          ListTile(leading: Text("Power range:"), title: Text(widget.power_range + '[cdbm]'),),
          ListTile(leading: Text("Status:"), title: Text(widget.status))
      ],)
    );
  }

}
