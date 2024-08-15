
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class PermissionAlertDialog extends StatefulWidget {
  const PermissionAlertDialog({super.key});

  @override
  State<PermissionAlertDialog> createState() => _PermissionAlertDialogState();
}

class _PermissionAlertDialogState extends State<PermissionAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Permission "),
      content: Text("Do you have permission to turn on location service?"),
      actions: [
        FloatingActionButton(onPressed: (){
          //transactions appropriate to yes
        }, child: const Text("Yes"),),
        FloatingActionButton(onPressed: (){
          Navigator.pop(context);
        }, child: const Text("No"),),
      ],
    );
  }
}
