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
                epcModal(widget.antennas, widget.power, widget.regions, widget.list[i].epc, "");
              }, 
            );
          }
        },
      )      
    );
  }

  void epcModal(List<dynamic> antennas, Map<String, dynamic> power, List<dynamic> regions, String epc, String message) {
    TextEditingController textController = TextEditingController();
    TextEditingController textController2 = TextEditingController();
    TextEditingController textController3 = TextEditingController();
    TextEditingController textController4 = TextEditingController();
    TextEditingController textController5 = TextEditingController();
    textController4.text = epc;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: ListView(
            children: [
              Text("Antenna:"),
              TextField(controller: textController),
              Text("Power:"),
              TextField(controller: textController2),
              Text("Region:"),
              TextField(controller: textController3),
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
                bool isantenna = false;
                bool dothings = true;
                for(var i = 0; i<antennas.length; i++){
                  if(antennas[i].toString() == textController.text){
                    isantenna = true;
                  }
                }
                if(isantenna == false){
                  dothings = false;
                  Navigator.of(context).pop();
                  epcModal(antennas, power, regions, epc,  "Antenna could not be found.");
                }
                if(power.values.first > int.parse(textController2.text) || power.values.last < int.parse(textController2.text)){
                  Navigator.of(context).pop();
                  epcModal(antennas, power, regions, epc, "Power is out of range.");
                  dothings = false;
                }
                bool isregion = false;
                for(var i = 0; i<regions.length; i++){
                  if(regions[i].toString() == textController3.text){
                    isregion = true;
                  }
                }
                if(isregion == false){
                  dothings = false;
                  Navigator.of(context).pop();
                  epcModal(antennas, power, regions, epc, "Region could not be found.");
                }
                if(dothings == true){
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  String token = prefs.getString('token');
                  try{
                    List<int> ant = [int.parse(textController.text)];
                    var epcjson = jsonEncode({'power': textController2.text, 'region': textController3.text, 'antennas': ant, 'epc_code': textController4.text, 'epc_target': textController5.text});
                    var response = await http.post('http://192.168.56.55/simple/write', headers: {'Content-Type':'application/json', 'token': token}, body: epcjson);
                    if(response.statusCode == 200){
                      Navigator.of(context).pop();
                    }
                    else{
                      Navigator.of(context).pop();
                      epcModal(antennas, power, regions, epc, "Error occured");
                    }       
                  }catch(error){
                    Navigator.of(context).pop();
                    epcModal(antennas, power, regions, epc, "Error occured");
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
