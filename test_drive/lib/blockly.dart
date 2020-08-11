import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Blockly extends StatefulWidget{
  String region;
  String q_dynamic;
  String q_value;
  String pyfile;
  String xmlfile;
  String status;

 Blockly({this.region, this.q_dynamic, this.q_value, this.pyfile, this.xmlfile, this.status});

  @override
  BlocklyState createState() => BlocklyState();

}

class BlocklyState extends State<Blockly>{

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context){
   return Scaffold(
      appBar: AppBar(title: Text("Blockly")),
      body: ListView(
        children: [
          ListTile(leading: Text("Region:"), title: Text(widget.region),),
          ListTile(leading: Text("Q value:"), title: Text(widget.q_value)),
          ListTile(leading: Text("Status:"), title: Text(widget.status)),
          ListTile(leading: Text("Q dynamic:"), title: Text(widget.q_dynamic)),
          ListTile(leading: Text("XML file:"), title: Text(widget.xmlfile.toString())),
          ListTile(leading: Text("Python file:"), title: Text(widget.pyfile.toString()),),
      ],)
    );
  }

}
