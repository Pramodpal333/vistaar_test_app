import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vistaar_test_app/controllers/scheduled/scheduled_controller.dart';
import 'package:vistaar_test_app/screens/scheduled/meeting_list.dart';
import 'package:vistaar_test_app/widgets/dialog.dart';
import 'package:vistaar_test_app/widgets/textfeild.dart';

class ScheduleScreen extends StatelessWidget {
  ScheduleScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var textTheme =
        Theme.of(context).textTheme.labelMedium!.copyWith(fontSize: 15);
    ScheduledController controller = Get.put(ScheduledController());
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Schedule'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Create New Schedule',
                  style: textTheme,
                ),
                SizedBox(
                  height: 15,
                ),
                CustomTextFormField(
                  readOnly: true,
                  label: 'Date',
                  hint: 'Enter date',
                  controller: controller.dateController,
                  keyboardType: TextInputType.datetime,
                  suffix: Icon(Icons.calendar_month_outlined),
                  validator: (value) {
                    // Your validation logic
                    if (value == null || value.isEmpty) {
                      return "Please enter date";
                    }
                    return null;
                  },
                  onTap: () async {
                    controller.pickDate(context);
                  },
                ),
                SizedBox(height: 16),
                CustomTextFormField(
                  suffix: Icon(Icons.watch_later_outlined),
                  readOnly: true,
                  label: 'Time',
                  hint: 'Enter time',
                  controller: controller.timeController,
                  keyboardType: TextInputType.datetime,
                  validator: (value) {
                    // Your validation logic
                    if (value == null || value.isEmpty) {
                      return "Please enter Time";
                    }
                    return null;
                  },
                  onTap: () {
                    controller.pickTime(context);
                  },
                ),
                SizedBox(height: 16),
                CustomTextFormField(
                  label: 'Doctor Name',
                  hint: 'Enter doctor name',
                  controller: controller.doctorController,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    // Your validation logic
                    if (value == null || value.isEmpty) {
                      return "Please enter doctor name";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                CustomTextFormField(
                  label: 'CC Email',
                  hint: 'Enter CC email',
                  controller: controller.ccEmailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    // Your validation logic
                    if (value == null || value.isEmpty) {
                      return "Please enter CC email";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Text('Schedule Online Meeting'),
                    Obx(
                      () => CupertinoSwitch(
                        value: controller.isOnlineMeeting.value,
                        onChanged: (value) {
                          controller.isOnlineMeeting.value = value;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Handle the button press
                    // if (_formKey.currentState!.validate()) {
                    //   controller.scheduleMeeting(context);
                    // }
                  },
                  child: Text('Schedule Meeting'),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Upcoming Schedule',
                  style: textTheme,
                ),
               Divider(),
               const SizedBox(
                  height: 15,
                ),
                Container(
                    height: Get.height *0.5,
                    child: MeetingListView())
              ],
            ),
          ),
        ),
      ),
    );
  }
}
