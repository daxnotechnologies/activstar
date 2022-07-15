
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<bool?> toastempty(BuildContext context,String text,Color color) {
  return Fluttertoast.showToast(
      textColor: Colors.white,
      backgroundColor:color,
      msg: "$text",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1);
}