import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:test_drive/check_update.dart';
import 'package:test_drive/list_wifi.dart';
import 'package:test_drive/menu.dart';
import 'package:test_drive/models.dart';
import 'package:test_drive/info.dart';
import 'package:test_drive/config.dart';
import 'package:test_drive/blockly.dart';
import 'package:test_drive/simple.dart';
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
        loginModal(context, readerName, "");
      }
      break;

      case 'get_info':{
        infoAction(context);
      }
      break;

      case 'get_config':{
        configAction(context);
      }
      break;

      case 'blockly_get_current':{
        blocklyAction(context);
      }
      break;

      case 'check_update':{
        checkUpdateAction(context);
      }
      break;

      case 'list_wifi':{
        listWifiAction(context);
      }
      break;

      case 'reset_factory':{
        factoryModal(context, "");
      }
      break;

      case 'set_password':{
        passModal(context, "");
      }
      break;

      case 'simple_config':{
        simpleAction(context);
      }
      break;

      default: {
  
      }
      break;
    }
  }

  Future<List<ListWifiResp>> listWifiAction(BuildContext context) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    final response = await http.get('http://192.168.56.55/network/wifi/list', headers: {"token": token});
    List<ListWifiResp> list = (json.decode(response.body) as List).map((data) => ListWifiResp.fromJson(data)).toList();
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context)=>ListWifi(
        list: list
      ))
    );
    return list;
  }

  Future<SimpleResp> simpleAction(BuildContext context) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    final response = await http.get('http://192.168.56.55/simple/config', headers: {"token": token});
    SimpleResp res = SimpleResp.fromJson(jsonDecode(response.body));
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context)=>Simple(
        antennas: res.antennas,
        power: res.power,
        regions: res.regions,
        time: res.time,
        inputs: res.inputs,
        outputs: res.outputs
      ))
    );
    return res;
  }

  Future<LoginResp> loginAction(String user, String password, BuildContext context, String readerName, UIDResp uid) async{
    LoginResp res;
    try{
      var jsonLogin = jsonEncode({"user": user, "password": password});
      final response = await http.post('http://192.168.56.55/login', headers: {'Content-Type':'application/json'}, body: jsonLogin);
      res = LoginResp.fromJson(jsonDecode(response.body));
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context)=>Menu(
            name: readerName,
            version: uid.version
          ))
        ); 
      return res;
    }catch(error){
      Navigator.of(context).pop();
      loginModal(context, readerName, "Credentials are invalid");
      return res;
    }
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

  Future<CheckUpdateResp> checkUpdateAction(BuildContext context) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    final response = await http.get('http://192.168.56.55/check_update', headers: {"token": token});
    CheckUpdateResp res = CheckUpdateResp.fromJson(jsonDecode(response.body));
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context)=>CheckUpdate(
        status: res.status,
        version: res.version,
        versions: res.versions
      ))
    );
    return res;
  }

  Future<BlocklyResp> blocklyAction(BuildContext context) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    final response = await http.get('http://192.168.56.55/blockly', headers: {"token": token});
    BlocklyResp res = BlocklyResp.fromJson(jsonDecode(response.body));
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context)=>Blockly(
        status: res.status,
        region: res.region,
        q_dynamic: res.q_dynamic,
        q_value: res.q_value,
        pyfile: res.pyfile,
        xmlfile: res.xmlfile,
      ))
    );
    return res;
  }

  Future<ConfigResp> configAction(BuildContext context) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    final response = await http.get('http://192.168.56.55/config', headers: {"token": token});
    ConfigResp res = ConfigResp.fromJson(jsonDecode(response.body));
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context)=>Config(
        model: res.model,
        api_key: res.api_key,
        gateway: res.gateway,
        disabled: res.disabled,
        netmask: res.netmask,
        keyy: res.keyy,
        ipaddr: res.ipaddr,
        mode: res.mode,
        proto: res.proto,
        rain_send_url: res.rain_send_url,
        tcp_port: res.tcp_port,
        timezone: res.timezone,
        datetime: res.datetime
      ))
    );
    return res;
  }
}

void loginModal(BuildContext context, String readerName, String message) {
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
                final response_uid = await http.get('http://192.168.56.55/uid');
                UIDResp res = UIDResp.fromJson(jsonDecode(response_uid.body));
                var response = ServiceActions().loginAction(textController.text, textController2.text, context, readerName, res);
                FutureBuilder<LoginResp>(
                  future: response,
                  builder: (context, snapshot) {
                    SharedPreferences.getInstance().then((prefs){
                      prefs.setString('token', snapshot.data.token);
                    });   
                  },
                );
              },
            )
          ],
        );
      },
    );
  }


void factoryModal(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            children: [
              Text(message)
            ],),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: Text("Reset"),
              onPressed: () async{
                SharedPreferences prefs = await SharedPreferences.getInstance();
                String token = prefs.getString('token');
                var jsonReset = jsonEncode({});
                try{
                  var response = await http.post('http://192.168.56.55/reset_factory', headers: {'Content-Type':'application/json', 'token': token}, body: jsonReset);
                  if(response.statusCode == 200){
                    Navigator.of(context).pop();
                  }
                  else{
                    Navigator.of(context).pop();
                    factoryModal(context, 'Error occured');
                  }
                }catch(error){
                  Navigator.of(context).pop();
                  factoryModal(context, 'Error occured');
                }
              },
            )
          ],
        );
      },
    );
  }

  void passModal(BuildContext context, String message) {
    TextEditingController textController = TextEditingController();
    TextEditingController textController2 = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            children: [
              Text("New password:"),
              TextField(controller: textController),
              Text("Confirm password"),
              TextField(controller: textController2,),
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
              child: Text("Confirm"),
              onPressed: () async{
                SharedPreferences prefs = await SharedPreferences.getInstance();
                String token = prefs.getString('token');
                if(textController2.text != textController.text){
                  Navigator.of(context).pop();
                  passModal(context, "Passwords are not identical");
                }
                else{
                  var jsonReset = jsonEncode({"password": textController.text, "password_confirm": textController2.text});
                  try{
                    var response = await http.post('http://192.168.56.55/password', headers: {'Content-Type':'application/json', 'token': token}, body: jsonReset);
                    if(response.statusCode == 200){
                      Navigator.of(context).pop();
                    }
                    else{
                      PassResp res = PassResp.fromJson(jsonDecode(response.body));
                      Navigator.of(context).pop();
                      var res2 = res.validation.values.toList();
                      factoryModal(context, res2[0]);
                    }
                  }catch(error){
                    Navigator.of(context).pop();
                    factoryModal(context, 'Error occured');
                  }
                }
              },
            )
          ],
        );
      },
    );
  }