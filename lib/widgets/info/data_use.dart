import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DataUse extends StatelessWidget {
  const DataUse({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AlertDialog(
        title: Text(
          'Chi vede i tuoi dati?',
          style: GoogleFonts.lato(
            fontSize: 18,
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          children: [
            Text(
              'Monitorare la felicità, la soddisfazione ed il benessere a lavoro consente ai TL/FAS di intervenire tempestivamente in caso di perdita di motivazione di uno dei componenti del team e, se necessario coinvolgere P&V. Inoltre consente all\u0027intero team di esserne a conoscenza e di supporto.',
              textAlign: TextAlign.justify,
              style: GoogleFonts.lato(
                fontSize: 16,
                color: Theme.of(context).colorScheme.onSecondaryContainer,
              ),
            ),
            Text(
              'Raccogliere i dati aggregati consente a P&V di monitorare quali siano i momenti dell\u0027anno più stressogeni e intervenire con azioni volte a far ricaricare le batterie e le energie per tutta l\u0027azienda (es: il trimestre del Ben-Essere).',
              textAlign: TextAlign.justify,
              style: GoogleFonts.lato(
                fontSize: 16,
                color: Theme.of(context).colorScheme.onSecondaryContainer,
              ),
            ),
            Text(
              'Condividere la propria motivazione e felicità consente a tutti noi di creare un\u0027azienda migliore!',
              textAlign: TextAlign.justify,
              style: GoogleFonts.lato(
                fontSize: 16,
                color: Theme.of(context).colorScheme.onSecondaryContainer,
              ),
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
