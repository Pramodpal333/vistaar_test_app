import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vistaar_test_app/widgets/dialog.dart';

import '../../data/dummy_data.dart';
import '../../model/meeting_model.dart';

class MeetingListView extends StatelessWidget {
  ScrollController _scrollController = ScrollController();

  // Function to scroll the ListView to the right
  void _scrollToRight() {
    _scrollController.animateTo(
      _scrollController.offset + Get.width * 0.8,
      // Adjust the scroll distance as needed
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  // Function to scroll the ListView to the left
  void _scrollToLeft() {
    _scrollController.animateTo(
      _scrollController.offset - Get.width * 0.8,
      // Adjust the scroll distance as needed
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    var w = Get.width;
    var h = Get.height;
    // Group meetings by date
    Map<String, List<Meeting>> groupedMeetings = groupMeetingsByDate(meetings);
    return Stack(
      children: [
        ListView.builder(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          itemCount: groupedMeetings.length,
          itemBuilder: (context, index) {
            String date = groupedMeetings.keys.elementAt(index);
            List<Meeting> meetingsOnDate = groupedMeetings[date]!;

            return Container(
              width: MediaQuery.of(context).size.width * 0.85,
              // margin: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Text(
                      'Date: $date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    height: h * 0.4, // Adjust the height as needed
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey.shade100),
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: meetingsOnDate.length,
                      itemBuilder: (context, innerIndex) {
                        Meeting meeting = meetingsOnDate[innerIndex];

                        return Container(
                          // width: 200, // Adjust the width as needed
                          margin: const EdgeInsets.all(5),
                          padding: const EdgeInsets.all(5),
                          // decoration: BoxDecoration(
                          //   borderRadius: BorderRadius.circular(8),
                          //   color: Colors.grey.shade100
                          // ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    '${meeting.time}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: w * 0.035,
                                    ),
                                  ),
                                ),
                                // const SizedBox(width:5 ,),
                                Expanded(
                                  child: Text(
                                    '${meeting.docName}',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: w * 0.035,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Flexible(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.edit_note,
                                            size: w * 0.06,
                                          )),
                                      IconButton(
                                          onPressed: () {
                                            confirmDialog(context,
                                                description:
                                                    "Delete the meeting of ${meeting.docName} on ${meeting.time}",
                                            onConfirm: (){},
                                              onCancel: ()=>Get.back()
                                            );
                                          },
                                          icon: Icon(
                                            Icons.delete_outline_outlined,
                                            size: w * 0.06,
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Divider(),
                ],
              ),
            );
          },
        ),
        Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          3), // Set the border radius to 0 for a square shape
                    ),
                  ),
                  onPressed: _scrollToLeft,
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black54,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          3), // Set the border radius to 0 for a square shape
                    ),
                  ),
                  onPressed: _scrollToRight,
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black54,
                  ),
                ),
              ],
            ))
      ],
    );
  }

  Map<String, List<Meeting>> groupMeetingsByDate(List<Meeting> meetings) {
    Map<String, List<Meeting>> groupedMeetings = {};

    for (Meeting meeting in meetings) {
      // Convert DateTime to String for grouping
      String formattedDate =
          meeting.date!.toLocal().toIso8601String().split('T')[0];

      if (!groupedMeetings.containsKey(formattedDate)) {
        groupedMeetings[formattedDate] = [];
      }

      groupedMeetings[formattedDate]!.add(meeting);
    }

    return groupedMeetings;
  }
}
