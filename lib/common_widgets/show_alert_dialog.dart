import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<dynamic> showAlertDialog(
  BuildContext context, {
  required String title,
  required String content,
  String? cancelActionText,
  required String defaultActionText,
}) {
  // if (!Platform.isIOS) {
  //   return showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: Text(title),
  //         content: Text(content),
  //         actions: [
  //           if (cancelActionText != null)
  //             FlatButton(
  //               child: Text(cancelActionText),
  //               onPressed:() => Navigator.of(context).pop(false),
  //             ),
  //           FlatButton(
  //             onPressed: () => Navigator.of(context).pop(true),
  //             child: Text(defaultActionText),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  return showCupertinoDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          if (cancelActionText != null)
            FlatButton(
              child: Text(cancelActionText),
              onPressed: () => Navigator.of(context).pop(false),
            ),
          FlatButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(defaultActionText),
          ),
        ],
      );
    },
  );
}
