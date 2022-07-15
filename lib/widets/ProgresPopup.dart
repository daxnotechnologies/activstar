import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

ProgressPopup(BuildContext context){
  return
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Container(child: Center(child: new CircularProgressIndicator()));

    },
  );
}