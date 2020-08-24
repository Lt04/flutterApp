import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_drive/taglist.dart';
import 'package:test_drive/models.dart';
import 'dart:convert';

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
          ListTile(leading: Text("Time:"), title: Text('[' + widget.time.values.first.toString() + ', ' + widget.time.values.last.toString() + '][ms]'),),
          ListTile(leading: Text("Inputs:"), title: Text(inp)),
          ListTile(leading: Text("Outputs:"), title: Text(outp)),
          Row(children: [
            Align(alignment: Alignment.bottomLeft, child: FloatingActionButton(
              onPressed: () async{
                readModal(widget.antennas, widget.power, widget.time, widget.regions,  "",  "", "");
              },
              heroTag: "btn1",
              child: Icon(Icons.router),
              backgroundColor: Colors.green,
            ),), 
        ],)
      ],)
    );
  }

  String dropRegion = 'EU3';
  String dropAnt = '1';

  void readModal(List<dynamic> antennas, Map<String, dynamic> power, Map<String, dynamic> time, List<dynamic> regions, String message, String txt2, String txt3) {
    TextEditingController textController2 = TextEditingController();
    TextEditingController textController3 = TextEditingController();
    textController2.text = txt2;
    textController3.text = txt3;
    List<String> ant = [];
    for(var i=0; i<antennas.length; i++){
      ant.addAll([antennas[i].toString()]);
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: ListView(
            children: [
              Text("Antenna:"),
              DropdownButton<String>(
                value: dropAnt,
                onChanged: (String newValue) {
                  Navigator.of(context).pop();
                  setState(() {
                  dropAnt = newValue;
                  });
                  readModal(antennas , power, time, regions, "", textController2.text, textController3.text);
                },
                items: ant
                .map<DropdownMenuItem<String>>((dynamic value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
                }).toList(),
              ),
              Text("Power:"),
              TextField(controller: textController2),
              Text("Time:"),
              TextField(controller: textController3),
              Text("Region:"),
              DropdownButton<String>(
                value: dropRegion,
                onChanged: (String newValue) {
                  Navigator.of(context).pop();
                  setState(() {
                  dropRegion = newValue;
                  });
                  readModal(antennas , power, time, regions, "", textController2.text, textController3.text);
                },
                items: regions
                .map<DropdownMenuItem<String>>((dynamic value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
                }).toList(),
              ),
              Text(message)
            ],
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: Text("Read"),
              onPressed: () async{
                bool dothings = true;
                if(power.values.first > int.parse(textController2.text) || power.values.last < int.parse(textController2.text)){
                  Navigator.of(context).pop();
                  readModal(antennas, power, time, regions, "Power is out of range.","", "");
                  dothings = false;
                }
                if(time.values.first > int.parse(textController3.text) || time.values.last < int.parse(textController3.text)){
                  Navigator.of(context).pop();
                  readModal(antennas, power, time, regions, "Time is out of range.", "", "");
                  dothings = false;
                }
                if(dothings == true){
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  String token = prefs.getString('token');
                  try{
                    var response = await http.get('http://192.168.56.55/simple/read?antennas=' + dropAnt + '&power=' + textController2.text + '&region=' + dropRegion + '&time=' + textController3.text, headers: {'token': token});
                    if(response.statusCode == 200){
                      List<ReadResp> list = (json.decode(response.body) as List).map((data) => ReadResp.fromJson(data)).toList();
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context)=>TagList(
                          list: list,
                          antennas: antennas,
                          regions: regions,
                          power: power
                        ))
                      );
                    }
                    else{
                      Navigator.of(context).pop();
                      readModal(antennas, power, time, regions, "Error occured", "", "");
                    }       
                  }catch(error){
                    Navigator.of(context).pop();
                    readModal(antennas, power, time, regions, "Error occured", "", "");
                  }
                }              
              },
            )
          ],
        );
      },
    );
  }

  

}
