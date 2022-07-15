import 'dart:convert';
import 'dart:io';
import 'package:activstar/constants/Urls.dart';
import 'package:activstar/constants/constants.dart';
import 'package:activstar/widets/ProgresPopup.dart';
import 'package:activstar/widets/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class signApi {
  Future login({var emaill, var password, var context}) async {
    ProgressPopup(context);
    Map body ={'email': '$emaill', 'password': '$password'};
    Map<String,String> headers = {
      "Content-Type": "application/json; charset=UTF-8" };
    var response = await http.post(
        Uri.parse(Login_Url),
        body: jsonEncode(body),
      headers: headers
    );
    print(jsonEncode(body));
    if (response.statusCode == 200) {
      print(response.body.toString());
      SharedPreferences prefs=await SharedPreferences.getInstance();
      prefs.setBool('Logined', true);
      prefs.setString('access_token',jsonDecode(response.body)['access_token']);
      access_token = jsonDecode(response.body)['access_token'].toString();
      prefs.setString('email', emaill);
      email = emaill; 
      Navigator.of(context).pop();
      print(jsonDecode(response.body)['access_token']);
      return true;
    } else {
      Navigator.of(context).pop();
      if (json.decode(response.body)['message'] ==
          'Nespravny email\/password') {
        toastempty(context, 'Nesprávny email alebo heslo', Colors.red);
      } else {
        toastempty(context, 'Login Failed', Colors.red);
      }
      return false;
    }
  }

  Future logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var access_token = prefs.getString('access_token');
    Map<String,String> headers = {
      "Content-Type": "application/json; charset=UTF-8", 
      "Authorization":"$access_token"};
    var response = await http.post(
        Uri.parse(Logout_Url),
        headers: headers
    );
    print(jsonEncode(response.body));
    print(response.body.toString());
    prefs.setBool('Logined', false);
    prefs.setString('access_token', "");
    access_token = "";
    prefs.setString('email', "");
    print(jsonDecode(response.body)['access_token']);
    return true;
  }

}
