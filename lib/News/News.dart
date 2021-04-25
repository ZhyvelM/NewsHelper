import 'package:flutter/material.dart';

class News {
  int id;
  String title;
  String description;
  String site;
  String link;
  DateTime dateTime;

  @override
  String toString() {
    return "id:$id title:$title description:$description site:$site link:$link date:$dateTime";
  }
}