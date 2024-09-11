import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        child: Column(
          children: [
            Text(
              'ERRORE!!',
              style: GoogleFonts.lato(),
            ),
            Text(message),
          ],
        ),
      ),
    );
  }
}
