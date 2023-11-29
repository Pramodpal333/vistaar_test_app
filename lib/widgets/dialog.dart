import 'package:flutter/material.dart';
import 'package:get/get.dart';

confirmDialog(BuildContext context, {String? title,required String description,Function()? onConfirm,Function()? onCancel}) {
  showDialog<String>(
    context: context,
    builder: (BuildContext ctx) =>
        AlertDialog(
          backgroundColor: Colors.white,
      title:  Text(title ?? 'Are you sure?'),
      content:  Text(description),
      actions: <Widget>[
        TextButton(
          onPressed: onCancel,
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: onConfirm,
          child: const Text('Confirm'),
        ),
      ],
    ),
  );
}
