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
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'ERRORE',
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSecondaryContainer,
              ),
            ),
            Text(
              errorMessage,
              style: GoogleFonts.lato(
                fontSize: 18,
                color: Theme.of(context).colorScheme.onSecondaryContainer,
              ),
            ),
            ElevatedButton(
              onPressed: onRetry,
              child: Text(
                'Riprova',
                style: GoogleFonts.lato(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
