
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/dummy_data.dart';
import '../model/meeting_model.dart';

loadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return PopScope(
        canPop: false,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircularProgressIndicator(color: Colors.blue,backgroundColor: Colors.black87,),
            ],
          ),
        ),
      );
    },
  );
}


stopLoading(){
  Get.back();
}






