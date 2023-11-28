import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:vistaar_test_app/network/api_constants.dart';
import 'package:vistaar_test_app/utils/utils.dart';
import 'package:vistaar_test_app/widgets/loading.dart';

class ScheduledController extends GetxController{
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController doctorController = TextEditingController();
  final TextEditingController ccEmailController = TextEditingController();
  final RxBool isOnlineMeeting = true.obs;
  Rx<DateTime>? selectedDate;

  Utils utils = Utils();

  //function to show date picker dialog
  Future<void> pickDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate?.value ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if(pickedDate != null){
      dateController.text = DateFormat("yyyy-MM-dd").format(pickedDate);
    }

  }

  //Function to show timepicker dialog
  Future<void> pickTime(BuildContext context) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      // Format the selected time using intl package
      String formattedTime = utils.formatTime(selectedTime);

      // Update the controller with the formatted time
      timeController.text = formattedTime;
    }
  }

  //Function to formate time



  //
  Future<void> scheduleMeeting( BuildContext context) async {
    try{
      loadingDialog(context);
      var body = {
        "date": dateController.text,
        "time": timeController.text,
        "doc_name":doctorController.text,
        "online_meeting": isOnlineMeeting.value ? "1":"0",
        "email_cc": ccEmailController.text
      };
      var header = utils.getHeader();
      var uri = Uri.parse(ApiConstants.baseUrl + ApiConstants.createUrl);
      var response = await post(uri,headers: header,body:jsonEncode(body) );
      log("Schedule Meeting response ===> ${response.statusCode} || ${response.body}");
      stopLoading();
    }catch(e){
      stopLoading();
      log("Schedule APi error >>>> $e");
    }
  }

}