import 'package:flutter/material.dart';

class ErrorBody extends StatelessWidget {
  const ErrorBody({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(message),
      ),
    );
  }
}
