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

  return picked;
}