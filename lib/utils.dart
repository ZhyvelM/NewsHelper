import 'dart:io';
import 'package:flutter/material.dart';
import 'News/NewsModel.dart';

Directory docsDir;

Future<DateTime> selectDate(BuildContext inContext, NewsModel inModel) async {
  print("## globals.selectDate()");

  DateTime picked = await showDatePicker(
      context: inContext,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018),
      lastDate: DateTime.now()
  );
  print("## globals.selectDate(): picked=$picked");
  return picked;
}

void showMessage(BuildContext inContext, String inMessage) {
  ScaffoldMessenger.of(inContext).showSnackBar(
      SnackBar(
          backgroundColor: Colors.black26,
          duration: Duration(seconds: 1),
          content: Text(inMessage, style: TextStyle(color: Colors.white,),)
      )
  );
}