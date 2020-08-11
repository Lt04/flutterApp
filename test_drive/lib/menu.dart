import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:test_drive/actions.dart';
import 'package:wifi/wifi.dart';
import 'package:http/http.dart' as http;


class Menu extends StatefulWidget{
  String name;

  Menu({this.name});

  @override
  MenuState createState() => MenuState();

}

class MenuState extends State<Menu>{

  List <Service> services = [
    new Service(
        name:"get_info", 
        tileName:"Info", 
        icon:Icon(Icons.info)
      ),
    ];
  

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context){
   return Scaffold(
      appBar: AppBar(title: Text(widget.name)),
      body: ListView.builder(
        itemBuilder: (context, i){
          if(services.length > i){
            return ListTile(
              title: Text(services[i].tileName),
              onTap: () async{
                ServiceActions().actions(services[i].name, context, widget.name);
              },
              leading: services[i].icon
            );
          }
        },
      ),
    );
  }
}

