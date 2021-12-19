import 'package:flutter/material.dart';

class AlertDart extends StatelessWidget {
  const AlertDart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
      title: const Text('Cat Image Downloaded'),
      content: SingleChildScrollView(
        child: ListBody(
          children: const <Widget>[
           Text("Cat image Downloaded")

          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('OK'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
