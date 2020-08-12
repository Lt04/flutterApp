import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:test_drive/actions.dart';

class Menu extends StatefulWidget{
  String name;
  String version;

  Menu({this.name, this.version});

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
    new Service(
      name: "get_config",
      tileName: "Config",
      icon: Icon(Icons.settings)
    ),
    new Service(
      icon: Icon(Icons.update),
      tileName: "Available updates",
      name: "check_update"
    )
  ];
  

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context){
   return Scaffold(
      appBar: AppBar(title: Text(widget.name + " " + widget.version)),
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

