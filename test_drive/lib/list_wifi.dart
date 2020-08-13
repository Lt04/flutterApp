import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:test_drive/models.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ListWifi extends StatefulWidget{
  List<ListWifiResp> list;

  ListWifi({this.list});

  @override
  ListWifiState createState() => ListWifiState();

}

class ListWifiState extends State<ListWifi>{

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context){
   return Scaffold(
      appBar: AppBar(title: Text("Wifi List")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                    itemBuilder: (context, i){
                      if(widget.list.length > i){
                        return ListTile(leading: Icon(Icons.wifi), title: Text(widget.list[i].ssid),);
                      }
                    },
                  )
          ),
          Row(children:[
            Align(alignment: Alignment.bottomLeft, child: FloatingActionButton(
              heroTag: "btn1",
              onPressed: () {
                wifiModal("");
              },
              child: Icon(Icons.add),
            ),),
            Align(alignment: Alignment.bottomRight, child: FloatingActionButton(
              heroTag: "btn2",
              onPressed: () {
                wifiDelModal("");
              },
              child: Icon(Icons.delete),
            ),)
        ])
        ],)    
    );
  }

  void wifiModal(String message) {
    TextEditingController textController = TextEditingController();
    TextEditingController textController2 = TextEditingController();
    TextEditingController textController3 = TextEditingController();
    TextEditingController textController4 = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: ListView(
            children: [
              Text("SSID:"),
              TextField(controller: textController),
              Text("Encryption:"),
              TextField(controller: textController2),
              Text("Password:"),
              TextField(controller: textController3,),
              Text("Repeat password:"),
              TextField(controller: textController4),
              Text(message)
            ],),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: Text("Add wi-fi"),
              onPressed: () async{
                if(textController4.text != textController3.text){
                  Navigator.of(context).pop();
                  wifiModal("Passwords are not identical");
                }
                else{
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  String token = prefs.getString('token');
                  var jsonWifi = jsonEncode({"ssid": textController.text, "encryption": textController2.text, "password": textController3.text});
                  try{
                    var response = await http.post('http://192.168.56.55/network/wifi/add', headers: {'Content-Type':'application/json', 'token': token}, body: jsonWifi);
                    if(response.statusCode == 200){
                      Navigator.of(context).pop();
                    }
                    else{
                      Navigator.of(context).pop();
                      wifiModal("Network could not be added");
                    }
                  }catch(error){
                    Navigator.of(context).pop();
                    wifiModal("Network could not be added");
                  }
                }
              },
            )
          ],
        );
      },
    );
  }

  void wifiDelModal(String message) {
    TextEditingController textController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: ListView(
            children: [
              Text("SSID:"),
              TextField(controller: textController),
              Text(message)
            ],),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: Text("Delete wi-fi"),
              onPressed: () async{
                SharedPreferences prefs = await SharedPreferences.getInstance();
                String token = prefs.getString('token');
                var jsonWifi = jsonEncode({"ssid": textController.text});
                try{
                  var response = await http.post('http://192.168.56.55/network/wifi/remove', headers: {'Content-Type':'application/json', 'token': token}, body: jsonWifi);
                  if(response.statusCode == 200){
                    Navigator.of(context).pop();
                  }
                  else{
                    Navigator.of(context).pop();
                    wifiDelModal("Network could not be deleted");
                  }
                }catch(error){
                  Navigator.of(context).pop();
                  wifiDelModal("Network could not be deleted");
                }
              }
            )
          ],
        );
      },
    );
  }


}
