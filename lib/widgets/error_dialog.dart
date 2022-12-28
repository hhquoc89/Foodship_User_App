import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final String message;
  ErrorDialog({required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.07,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.red)),
              child: const Icon(
                Icons.close,
                color: Colors.red,
              ),
            ),
            Center(child: Text(message)),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.red,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Center(
            child: Text("Ok"),
          ),
        ),
      ],
    );
  }
}
