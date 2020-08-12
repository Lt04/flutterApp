import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Config extends StatefulWidget{
  String model;
  String api_key;
  String keyy;
  String disabled;
  String netmask;
  String gateway;
  String ipaddr;
  String proto;
  String mode;
  String tcp_port;
  String rain_send_url;
  String timezone;
  String datetime;

Config({this.model, this.api_key, this.keyy, this.disabled, this.netmask, this.gateway, this.ipaddr, this.mode, this.proto, this.rain_send_url, this.tcp_port, this.datetime, this.timezone});

  @override
  ConfigState createState() => ConfigState();

}

class ConfigState extends State<Config>{

  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context){
   return Scaffold(
      appBar: AppBar(title: Text("Config")),
      body: ListView(
        children: [
          ListTile(leading: Text("Model:"), title: Text(widget.model),),
          ListTile(leading: Text("Api key:"), title: Text(widget.api_key)),
          ListTile(leading: Text("Key:"), title: Text(widget.keyy)),
          ListTile(leading: Text("Disabled:"), title: Text(widget.disabled)),
          ListTile(leading: Text("Netmask:"), title: Text(widget.netmask),),
          ListTile(leading: Text("Gateway:"), title: Text(widget.gateway),),
          ListTile(leading: Text("IP address:"), title: Text(widget.ipaddr)),
          ListTile(leading: Text("Proto:"), title: Text(widget.proto)),
          ListTile(leading: Text("Mode:"), title: Text(widget.mode)),
          ListTile(leading: Text("TCP port:"), title: Text(widget.tcp_port)),
          ListTile(leading: Text("Rain send URL"), title: Text(widget.rain_send_url)),
          ListTile(leading: Text("Timezone:"), title: Text(widget.timezone)),
          ListTile(leading: Text("Datetime:"), title: Text(widget.datetime)),
          FloatingActionButton(
            onPressed: (){
              netConfigModal(widget.proto, widget.ipaddr, widget.netmask, widget.gateway, "");
            },
            child: Icon(Icons.wifi),
            backgroundColor: Colors.green,
          )
      ],)
    );
  }

  void netConfigModal(String proto, String ipaddr, String netmask, String gateway, String message) {
    TextEditingController textController = TextEditingController();
    TextEditingController textController2 = TextEditingController();
    TextEditingController textController3 = TextEditingController();
    TextEditingController textController4 = TextEditingController();
    textController.text = proto;
    textController2.text = ipaddr;
    textController3.text = netmask;
    textController4.text = gateway;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            children: [
              Text("Proto:"),
              TextField(controller: textController),
              Text("IP address:"),
              TextField(controller: textController2,),
              Text("Netmask:"),
              TextField(controller: textController3,),
              Text("Gateway:"),
              TextField(controller: textController4),
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
                var jsonNet;
                if(textController.text == "dhcp"){
                  jsonNet = jsonEncode({"proto": textController.text});
                }
                else{
                  jsonNet = jsonEncode({"proto": textController.text, "ipaddr": textController2.text, "netmask": textController3.text, "gateway": textController4.text});
                }
                try{
                  var response = await http.post('http://192.168.56.55/config/network', headers: {'Content-Type':'application/json', 'token': token}, body: jsonNet);
                  setState((){
                    widget.proto = textController.text;
                    widget.ipaddr = textController2.text;
                    widget.netmask = textController3.text;
                    widget.gateway = textController4.text;
                  });
                  Navigator.of(context).pop();
                }catch(error){
                  Navigator.of(context).pop();
                  netConfigModal(proto, ipaddr, netmask, gateway, "Error occured");
                }
              },
            )
          ],
        );
      },
    );
  }

}