import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/objects/date-hour.dart';
import 'Teacher.dart';

class News{
  late String title;
  late String context;
  late String tag;

  News({required this.title, required this.context, required this.tag});

  factory News.fromJson(Map<String, dynamic> json) {
     return News(
         title: json['title'],
         context: json['context'],
         tag: json['tag']
     );
  }

}
