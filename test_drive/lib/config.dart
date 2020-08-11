import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:test_drive/actions.dart';


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
          ListTile(leading: Text("Datetime:"), title: Text(widget.datetime))
      ],)
    );
  }

}