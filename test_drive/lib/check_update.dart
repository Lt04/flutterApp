import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CheckUpdate extends StatefulWidget{
  String version;
  List<dynamic> versions;
  String status;

  CheckUpdate({this.version, this.versions, this.status});

  @override
  CheckUpdateState createState() => CheckUpdateState();

}

class CheckUpdateState extends State<CheckUpdate>{

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context){
   return Scaffold(
      appBar: AppBar(title: Text("Available updates")),
      body: ListView.builder(
        itemBuilder: (context, i){
          if(widget.versions.length > i){
            return ListTile(
              title: Text(widget.versions[i]),
              onTap: (){
                downloadModal(widget.versions[i], "");
              },
            );
          }
        }
      )
    );
  }

  void downloadModal(String version, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(message),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: Text("Download"),
              onPressed: () async{
                SharedPreferences prefs = await SharedPreferences.getInstance();
                String token = prefs.getString('token');
                var jsonDownload = jsonEncode({"version": version});
                var response = await http.post('http://192.168.56.55/download_update', headers: {'Content-Type':'application/json', 'token': token}, body: jsonDownload);
                if(response.statusCode != 200){
                  Navigator.of(context).pop();
                  message = "Download failed";
                  downloadModal(version, message);
                }
                else{
                  Navigator.of(context).pop();
                }
              },
            )
          ],
        );
      },
    );
  }

}

