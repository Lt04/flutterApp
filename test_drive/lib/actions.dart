import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:test_drive/menu.dart';
import 'package:test_drive/models.dart';

class Service{
  final String name;
  final String tileName;
  final Icon icon;

  Service({this.name, this.tileName, this.icon});

}

class ServiceActions{
  void actions(String name){
    switch(name){
      case 'login':{

      }
      break;

      default: {
  
      }
      break;
    }
  }

  LoginResp loginAction(String user, String password){

    final response = http.post('http://10.100.10.46', headers: {'Content-Type':'application/json'});
  }
  //tu funkcje wywolywane w switchu
}