import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vistaar_test_app/screens/scheduled/scheduled_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(child: ElevatedButton(onPressed: (){
          Get.to(()=> ScheduleScreen());
        }, child: const Text("Schedule"))),
      ),
    );
  }
}
