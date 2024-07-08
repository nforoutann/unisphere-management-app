import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/objects/date-hour.dart';
import 'Teacher.dart';

class Course{
  late String teacher;
  late String title;
  late int credit;
  late String code;
  late List<date> time;
  late String numberOfDefinedAssignments;
  late String nameOfBestStudent;


  Course({required this.title,required this.teacher,required this.credit,required this.code, required this.time, required this.nameOfBestStudent, required this.numberOfDefinedAssignments});


  factory Course.fromJson(Map<String, dynamic> json) {
    List<date> time = [];
    if(json['time'] != null){
      var timeJson = json['time'] as List;
      for(int i=0 ; i<timeJson.length ; i++){
        String timeJsonStr =timeJson[i].toString();
        time.add(date(EndHour: timeJsonStr.split("=")[1].split("~")[1], startHour: timeJsonStr.split("=")[1].split("~")[0], weekDay: timeJsonStr.split("=")[0]));
      }
    }

    return Course(
      title: json['title'],
      code: json['code'],
      credit: int.parse(json['credit']),
      teacher: json['teacher'],
      time: time,
      nameOfBestStudent: json['nameOfBestStudent'],
      numberOfDefinedAssignments: json['numberOfDefinedAssignments']
    );
  }

}
