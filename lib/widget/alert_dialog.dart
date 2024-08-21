import 'package:flutter/material.dart';

class PermissionAlertDialog extends StatefulWidget {
  const PermissionAlertDialog({super.key});

  @override
  State<PermissionAlertDialog> createState() => _PermissionAlertDialogState();
}

class _PermissionAlertDialogState extends State<PermissionAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Permission "),
      content: const Text("Do you have permission to turn on location service?"),
      actions: [
        FloatingActionButton(onPressed: (){

        }, child: const Text("Yes"),),
        FloatingActionButton(onPressed: (){
          Navigator.pop(context);
        }, child: const Text("No"),),
      ],
    );
  }
}
