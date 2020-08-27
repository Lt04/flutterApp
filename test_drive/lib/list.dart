import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:wifi/wifi.dart';
import 'package:connectivity/connectivity.dart';
import 'dart:async';
import 'package:test_drive/actions.dart';
import 'package:barcode_scan/barcode_scan.dart';

class PasteList extends StatefulWidget{

  @override
  ListState createState() => ListState();
}

class ListState extends State<PasteList>{

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (Timer t){
      setState(() { 
      });
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: wifiList(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  wifiModal(String name, String message){
    TextEditingController textController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Password"),
          content: Column(children: [TextField(controller: textController), Text(message)]),
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
                  else{
                    Navigator.of(context).pop();
                    message = "Password is invalid";
                    wifiModal(name, message);
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
             if(snapshot.data != null && snapshot.data.length > i && snapshot.data[i].ssid.toString().length > 6 && snapshot.data[i].ssid.toString().substring(0,7) == 'EREFIDE'){
               return ListTile(
                 subtitle: Text(snapshot.data[i].level.toString()),
                 title: Text(snapshot.data[i].ssid.toString()),
                 leading: Icon(FontAwesome.wifi, color: Colors.green),
                 onTap: (){
                   Connectivity().getWifiName().then((name){
                    if(name == null){
                      wifiModal(snapshot.data[i].ssid.toString(), "");
                    }
                    else if(name != null && name == snapshot.data[i].ssid.toString()){
                      ServiceActions().actions("login", context, snapshot.data[i].ssid.toString());
                    }
                    else{
                      wifiModal(snapshot.data[i].ssid.toString(), "");  
                    }
                   });
                 },
               );
             }
             else if(snapshot.data != null && snapshot.data.length == i+1){
               return FloatingActionButton.extended(
                        onPressed: _scanQR,
                        icon: Icon(Icons.camera_alt),
                        backgroundColor: Colors.green,
                        label: Text("Scan QR code"),                 
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

  Future _scanQR() async{
    try{
      ScanResult qrResult = await BarcodeScanner.scan();
      Connectivity().getWifiName().then((name){
        if(name == null){
          wifiModal(qrResult.rawContent, "");
        }
        else if(name != null && name == qrResult.rawContent){
          ServiceActions().actions("login", context, qrResult.rawContent);
        }
        else{
          wifiModal(qrResult.rawContent, "");  
        }
      });
    }catch(e){
      print(e);
    }
  }

  Future<List<WifiResult>> getWifi() async{
    List<WifiResult> list = await Wifi.list('');
    return list;
  }

}
