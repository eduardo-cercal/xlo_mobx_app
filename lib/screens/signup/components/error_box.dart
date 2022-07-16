import 'package:flutter/material.dart';

class ErrorBox extends StatelessWidget {
  final String? message;

  const ErrorBox({this.message, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (message == null) {
      return Container();
    } else {
      return Container(
        color: Colors.red,
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.white,
              size: 40,
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: Text(
                "Oops! $message. Por favor, tente novamente.",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
