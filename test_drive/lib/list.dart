import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:test_drive/ontap.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:wifi/wifi.dart';
import 'package:connectivity/connectivity.dart';
import 'dart:async';
import 'package:test_drive/menu.dart';


class PasteList extends StatefulWidget{

  @override
  ListState createState() => ListState();
}

class ListState extends State<PasteList>{
  List<Album> lista = [];

  ScrollController _controller;
  int start = 0;

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    super.initState();
    Timer.periodic(Duration(seconds: 1), (Timer t){
      setState(() { 
      });
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: wifiList()
    );
  }

  _scrollListener(){
    if(_controller.offset >= _controller.position.maxScrollExtent && !_controller.position.outOfRange){
      start += 10;
      setState((){});
    }
  }

  void wifiModal(String name) {
    TextEditingController textController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Password"),
          content: TextField(controller: textController),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: Text("Connect"),
              onPressed: (){
                Wifi.connection(name, textController.text).then((result){
                  if(result == WifiState.success){
                    Navigator.of(context).pop();
                  }
                });
              },
            )
          ],
        );
      },
    );
  }

  Widget wifiList(){
    return FutureBuilder(
      future: getWifi(),
      builder: (context, snapshot){
        return ListView.builder(
           itemBuilder: (context, i){
             if(snapshot.data != null && snapshot.data.length > i && snapshot.data[i].ssid.toString().substring(0,7) == 'EREFIDE'){
               return ListTile(
                 subtitle: Text(snapshot.data[i].level.toString()),
                 title: Text(snapshot.data[i].ssid.toString()),
                 leading: Icon(FontAwesome.wifi, color: Colors.green),
                 onTap: (){
                   Connectivity().getWifiName().then((name){
                    if(name == null){
                      wifiModal(snapshot.data[i].ssid.toString());
                    }
                    else if(name != null && name == snapshot.data[i].ssid.toString()){
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context)=>Menu(
                          name: snapshot.data[i].ssid.toString(),
                        ))
                      ); 
                    }
                    else{
                      wifiModal(snapshot.data[i].ssid.toString());
                    }
                   });
                 },
               );
             }
             else if(snapshot.data != null && snapshot.data.length > i){
               return Container();
             }
           },
        );
      } 
    );
  }

  Widget listFromInternet(){
    return FutureBuilder(
      builder: (context, projectSnap){
        if(projectSnap.data == null || projectSnap.data.length == 0){
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
              IconButton(
                icon: Icon(EvilIcons.refresh, size: 30.0),
                onPressed: (){
                  setState((){
                  });
                }
              ),
              Text("Refresh")
            ])],
          );
        }else{
          return ListView.builder(
            controller: _controller,
            itemBuilder: (context, i){
              if(projectSnap.data.length > i){
                return ListTile(
                  subtitle: Text(projectSnap.data[i].title),
                  title: Text(projectSnap.data[i].id.toString()),
                  leading: Icon(FontAwesome.gamepad, color: Colors.green),
                  onTap: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context)=>Ontap(
                        title: projectSnap.data[i].id.toString(),
                      ))
                    ); 
                  }
                );
              }
            }
          );
        }
      },
      future: fetchAlbum()
    );
  }

  Future<List<WifiResult>> getWifi() async{
    List<WifiResult> list = await Wifi.list('');
    return list;
  }

  Future<List<Album>> fetchAlbum() async {
    try{  
      final response = await http.get('https://jsonplaceholder.typicode.com/albums?_start=' + start.toString() + '&_limit=10');
      if (response.statusCode == 200) {
        List<Album> list = (json.decode(response.body) as List).map((data) => Album.fromJson(data)).toList();
        lista = new List.from(lista)..addAll(list);
        return lista;
      }
      else{
        return [];
      }
    }catch(_){
      return [];
    }
  }
 
}

class Album {
  final int userId;
  final int id;
  final String title;

  Album._({this.userId, this.id, this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return new Album._(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}