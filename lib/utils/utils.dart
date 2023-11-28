import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class Utils{
  GetStorage _box = GetStorage();

  String formatTime(TimeOfDay timeOfDay) {
    // Format the time using the intl package
    final now = DateTime.now();
    DateTime selectedDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      timeOfDay.hour,
      timeOfDay.minute,
    );

    return DateFormat.jm().format(selectedDateTime);
  }

  getHeader(){
    return {
      'Content-type': 'application/json',
      'Accept': 'application/json'};
  }

}