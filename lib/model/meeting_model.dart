import 'dart:convert';

class Meeting {
  String? id;
  DateTime? date;
  String? time;
  String? docName;
  String? onlineMeeting;
  String? emailCc;

  Meeting({
    this.id,
    this.date,
    this.time,
    this.docName,
    this.onlineMeeting,
    this.emailCc,
  });

  factory Meeting.fromJson(Map<String, dynamic> json) => Meeting(
    id: json["id"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    time: json["time"],
    docName: json["doc_name"],
    onlineMeeting: json["online_meeting"],
    emailCc: json["email_cc"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "time": time,
    "doc_name": docName,
    "online_meeting": onlineMeeting,
    "email_cc": emailCc,
  };
}
