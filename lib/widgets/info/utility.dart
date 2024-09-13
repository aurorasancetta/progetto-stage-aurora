import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_at_work/models/bullet_list.dart';

class Utility extends StatelessWidget {
  const Utility({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AlertDialog(
        title: Text(
          'A cosa serve Happy@Work?',
          style: GoogleFonts.lato(
            fontSize: 18,
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          children: [
            Text(
              'H@W vuole essere uno strumento per monitorare la motivazione e la felicità al lavoro.  Gli ambiti che se soddisfatti generano motivazione a lavoro sono inerenti a:',
              textAlign: TextAlign.justify,
              style: GoogleFonts.lato(
                fontSize: 16,
                color: Theme.of(context).colorScheme.onSecondaryContainer,
              ),
            ),
            const BulletList(
              [
                'La qualità delle tue relazioni e la positività del clima lavorativo;',
                'Avere a disposizione la corretta formazione del ruolo per la conquista della propria autonomia;',
                'Chiarezza degli obiettivi e piena responsabilità di gestione nel tuo ruolo;',
                'Sentirsi apprezzato e ricevere il giusto riconoscimento;',
                'Sentirsi in crescita;',
                'Compiti e attività;',
                'Bilanciamento sfera personale e professionale.',
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, 'Okay'),
            child: Text(
              'Okay',
              style: GoogleFonts.lato(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
