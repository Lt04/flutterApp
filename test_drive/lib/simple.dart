import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Simple extends StatefulWidget{
  List<dynamic> antennas;
  Map<String, dynamic> power;
  List<dynamic> regions;
  Map<String, dynamic> time;
  List<dynamic> inputs;
  List<dynamic> outputs;

  Simple({this.power, this.antennas, this.time, this.inputs, this.regions, this.outputs});

  @override
  SimpleState createState() => SimpleState();

}

class SimpleState extends State<Simple>{

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context){
   String ant = "";
   for(var i = 0; i<widget.antennas.length; i++){
     if(i == widget.antennas.length-1){
       ant += widget.antennas[i].toString();
     }
     else{
       ant += widget.antennas[i].toString() + ', ';
     }   
   }
   String reg = "";
   for(var i = 0; i < widget.regions.length; i++){
     if(i == widget.regions.length-1){
       reg += widget.regions[i].toString();
     }
     else{
       reg += widget.regions[i].toString() + ', ';
     } 
   }
   String inp = "";
   for(var i = 0; i < widget.inputs.length; i++){
     if(i == widget.inputs.length-1){
       inp += widget.inputs[i].toString();
     }
     else{
       inp += widget.inputs[i].toString() + ', ';
     } 
   }
   String outp = "";
   for(var i = 0; i < widget.outputs.length; i++){
     if(i == widget.outputs.length-1){
       outp += widget.outputs[i].toString();
     }
     else{
       outp += widget.outputs[i].toString() + ', ';
     } 
   }
   return Scaffold(
      appBar: AppBar(title: Text("Simple")),
      body: ListView(
        children: [
          ListTile(leading: Text("Antennas:"), title: Text(ant)),
          ListTile(leading: Text("Power:"), title: Text('[' + widget.power.values.first.toString() + ', ' + widget.power.values.last.toString() + ']'),),
          ListTile(leading: Text("Regions:"), title: Text(reg)),
          ListTile(leading: Text("Time:"), title: Text('[' + widget.time.values.first.toString() + ', ' + widget.time.values.last.toString() + ']'),),
          ListTile(leading: Text("Inputs:"), title: Text(inp)),
          ListTile(leading: Text("Outputs:"), title: Text(outp))
      ],)
    );
  }

}
