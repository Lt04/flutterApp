import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:test_drive/models.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TagList extends StatefulWidget{
  List<ReadResp> list;
  List<dynamic> antennas;
  List<dynamic> regions;
  Map<String, dynamic> power;


  TagList({this.power, this.antennas, this.list, this.regions});

  @override
  TagListState createState() => TagListState();

}

class TagListState extends State<TagList>{

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context){
   return Scaffold(
      appBar: AppBar(title: Text("TagList")),
      body: ListView.builder(
        itemBuilder: (context, i){
          if(widget.list.length > i){
            return ListTile(
              title: Text(widget.list[i].epc),
              onTap: (){
                epcModal(widget.antennas, widget.power, widget.regions, widget.list[i].epc, "", "");
              }, 
            );
          }
        },
      )      
    );
  }
  String dropRegion = 'EU3';
  String dropAnt = '1';
  double valSlider = 20;

  void epcModal(List<dynamic> antennas, Map<String, dynamic> power, List<dynamic> regions, String epc,  String targ, String message) {
    TextEditingController textController4 = TextEditingController();
    TextEditingController textController5 = TextEditingController();
    textController4.text = epc;
    textController5.text = targ;
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
                  epcModal(antennas , power, regions, textController4.text, textController5.text, "");
                },
                items: ant
                .map<DropdownMenuItem<String>>((dynamic value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
                }).toList(),
              ),
              Text("Power: " + valSlider.toString()),
              Slider(
                value: valSlider,
                min: power.values.first,
                max: power.values.last,
                divisions: 8,
                label: valSlider.round().toString(),
                onChanged: (double value) {
                  Navigator.of(context).pop();
                  setState(() {
                    valSlider = value.floor().toDouble();
                  });
                  epcModal(antennas , power, regions, textController4.text, textController5.text, "");
                },
              ),
              Text("Region:"),
              DropdownButton<String>(
                value: dropRegion,
                onChanged: (String newValue) {
                  Navigator.of(context).pop();
                  setState(() {
                    dropRegion = newValue;
                  });
                  epcModal(antennas , power, regions, textController4.text, textController5.text, "");
                },
                items: regions
                .map<DropdownMenuItem<String>>((dynamic value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
                }).toList(),
              ),
              Text("Epc code:"),
              TextField(controller: textController4),
              Text("Target epc:"),
              TextField(controller: textController5),
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
              child: Text("Confirm"),
              onPressed: () async{
                SharedPreferences prefs = await SharedPreferences.getInstance();
                String token = prefs.getString('token');
                try{
                  List<int> ant = [int.parse(dropAnt)];
                  var epcjson = jsonEncode({'power': valSlider, 'region': dropRegion, 'antennas': ant, 'epc_code': textController4.text, 'epc_target': textController5.text});
                  var response = await http.post('http://192.168.56.55/simple/write', headers: {'Content-Type':'application/json', 'token': token}, body: epcjson);
                  if(response.statusCode == 200){
                    Navigator.of(context).pop();
                  }
                  else{
                    Navigator.of(context).pop();
                    epcModal(antennas , power, regions, textController4.text, textController5.text, "");
                  }       
                }catch(error){
                  Navigator.of(context).pop();
                  epcModal(antennas , power, regions, textController4.text, textController5.text, "");
                }            
              },
            )
          ],
        );
      },
    );
  }

}
