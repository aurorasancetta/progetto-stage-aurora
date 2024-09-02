import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.onPrimary,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                const Placeholder(
                  fallbackHeight: 72,
                  fallbackWidth: 72,
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nome Cognome',
                      style: GoogleFonts.lato(fontSize: 18),
                    ),
                    Text(
                      'Nome team',
                      style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Text(
            'INFORMAZIONI',
            style: GoogleFonts.lato(
              fontSize: 16,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {},
              style: ButtonStyle(
                shape: const WidgetStatePropertyAll(
                  RoundedRectangleBorder(),
                ),
                backgroundColor: WidgetStatePropertyAll(
                    Theme.of(context).colorScheme.surface),
              ),
              label: Text(
                'Informazioni su Happy@Work',
                style: GoogleFonts.lato(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              icon: const Icon(
                Icons.arrow_forward,
                color: Colors.black,
              ),
              iconAlignment: IconAlignment.end,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'IMPOSTAZIONI',
            style: GoogleFonts.lato(
              fontSize: 16,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {},
              style: ButtonStyle(
                shape: const WidgetStatePropertyAll(
                  RoundedRectangleBorder(),
                ),
                backgroundColor: WidgetStatePropertyAll(
                    Theme.of(context).colorScheme.surface),
              ),
              label: Text(
                'Esci',
                style: GoogleFonts.lato(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              icon: const Icon(
                Icons.exit_to_app,
                color: Colors.black,
              ),
              iconAlignment: IconAlignment.end,
            ),
          ),
        ],
      ),
    );
  }
}
