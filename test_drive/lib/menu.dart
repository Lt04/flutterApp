import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:test_drive/actions.dart';

class Menu extends StatefulWidget{
  String name;

  Menu({this.name});

  @override
  MenuState createState() => MenuState();

}

class MenuState extends State<Menu>{

  List <Service> services = [
    new Service(
        name:"login", 
        tileName:"Log in", 
        icon:Icon(Icons.battery_unknown)
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
                ServiceActions().actions(services[i].name);
              },
              leading: services[i].icon
            );
          }
        },
      ),
    );
  }
}

