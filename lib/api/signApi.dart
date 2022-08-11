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
      if(await accountInfo())
        return true;
      else
        return false;
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
    prefs.setString('email', '');
    prefs.setString('fbShare', '');
    prefs.setString('telegramShare', '');
    print(jsonDecode(response.body)['access_token']);
    return true;
  }

  Future accountInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? access_token = await prefs.getString('access_token');

    Map<String,String> headers = {
      "Content-Type": "application/json; charset=UTF-8" , "Authorization" : access_token!};
    var response = await http.get(
        Uri.parse(accountInfoUrl),
        headers: headers
    );
    if (response.statusCode == 200) {
      SharedPreferences prefs=await SharedPreferences.getInstance();
      prefs.setString('fbShare', jsonDecode(response.body)['share']['facebook'].toString());
      prefs.setString('telegramShare', jsonDecode(response.body)['share']['twitter'].toString());
      return true;
    } else {
      return false;
    }
  }


  Future invitePerson(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? access_token = await prefs.getString('access_token');
    Map body ={'email': '$email'};

    Map<String,String> headers = {
      "Content-Type": "application/json; charset=UTF-8" , "Authorization" : access_token!};
    var response = await http.post(
        Uri.parse(inviteUrl),
        body: jsonEncode(body),
        headers: headers
    );
    if (response.statusCode == 200) {
      if ((jsonDecode(response.body)['success']) == true)
        return true;
      else
        return false;
    } else {
      return false;
    }
  }
  Future deleteAccount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? access_token = await prefs.getString('access_token');
    Map body ={'confirm': 'YES'};

    Map<String,String> headers = {
      "Content-Type": "application/json; charset=UTF-8" , "Authorization" : access_token!};
    var response = await http.post(
        Uri.parse(deleteUrl),
        body: jsonEncode(body),
        headers: headers
    );
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      if ((jsonDecode(response.body)['success']) == true){
        prefs.setBool('Logined', false);
        prefs.setString('access_token', "");
        access_token = "";
        prefs.setString('email', '');
        prefs.setString('fbShare', '');
        prefs.setString('telegramShare', '');
        return true;
      }
      else
        return false;
    } else {
      return false;
    }
  }


}
