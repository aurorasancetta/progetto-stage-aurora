import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RetryScreen extends StatelessWidget {
  const RetryScreen({
    super.key,
    required this.errorMessage,
    required this.onRetry,
  });

  final String errorMessage;
  final void Function() onRetry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              errorMessage,
              style: GoogleFonts.lato(),
            ),
            ElevatedButton(
              onPressed: onRetry,
              child: Text(
                'Riprova',
                style: GoogleFonts.lato(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
