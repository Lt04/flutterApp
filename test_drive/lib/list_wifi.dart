import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:test_drive/models.dart';

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
      body: ListView.builder(
        itemBuilder: (context, i){
          if(widget.list.length > i){
            return ListTile(leading: Icon(Icons.wifi), title: Text(widget.list[i].ssid),);
          }
        },
      )
    );
  }

}
