import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:test_drive/menu.dart';
import 'package:test_drive/models.dart';
import 'package:test_drive/info.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Service{
  final String name;
  final String tileName;
  final Icon icon;

  Service({this.name, this.tileName, this.icon});

}


class ServiceActions{
  void actions(String name, BuildContext context, String readerName){
    switch(name){
      case 'login':{
        loginModal(context, readerName);
      }
      break;

      case 'get_info':{
        infoAction(context);
        /*FutureBuilder<InfoResp>(
          future: resp,
          builder: (context, snapshot) {
            print(snapshot.data.antennas);
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context)=>Info(
                model: snapshot.data.model,
                antennas: snapshot.data.antennas,
                status: snapshot.data.status,
                serial: snapshot.data.serial,
                connected: snapshot.data.connected,
                regions: snapshot.data.regions,
                power_range: snapshot.data.power_range,
              ))
            ); 
          },
        );*/
      }
      break;

      default: {
  
      }
      break;
    }
  }

  Future<LoginResp> loginAction(String user, String password) async{
    var jsonLogin = jsonEncode({"user": user, password: password});
    final response = await http.post('http://192.168.56.55/login', headers: {'Content-Type':'application/json'}, body: jsonLogin);
    LoginResp res = LoginResp.fromJson(jsonDecode(response.body));
    return res;
  }

  Future<InfoResp> infoAction(BuildContext context) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    final response = await http.get('http://192.168.56.55/info', headers: {"token": token});
    InfoResp res = InfoResp.fromJson(jsonDecode(response.body));
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context)=>Info(
        model: res.model,
        antennas: res.antennas,
        status: res.status,
        serial: res.serial,
        connected: res.connected,
        regions: res.regions,
        power_range: res.power_range,
      ))
    );
    return res;
  }
}

void loginModal(BuildContext context, String readerName) {
    String message = "";
    TextEditingController textController = TextEditingController();
    TextEditingController textController2 = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            children: [
              Text("Login:"),
              TextField(controller: textController),
              Text("Password:"),
              TextField(controller: textController2),
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
              child: Text("Log in"),
              onPressed: () async{
                /*var response = ServiceActions().loginAction(textController.text, textController2.text);
                FutureBuilder<LoginResp>(
                  future: response,
                  builder: (context, snapshot) {
                    SharedPreferences.getInstance().then((prefs){
                      prefs.setString('token', snapshot.data.token);
                    });   
                  },
                );*/
                if(textController.text == "admin" && textController2.text == "admin"){
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.setString('token', "7bc495f0b3e939d95314aa9f5775cb987d0cb44a");
                  Navigator.of(context).push(
                        MaterialPageRoute(builder: (context)=>Menu(
                          name: readerName,
                        ))
                  ); 
                }
                else{
                  message = "Login or password is invalid.";
                }
              },
            )
          ],
        );
      },
    );
  }
