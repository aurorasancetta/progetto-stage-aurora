import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_at_work/api/microsoft_auth.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

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
                      style: GoogleFonts.lato(
                        fontSize: 18,
                        color:
                            Theme.of(context).colorScheme.onSecondaryContainer,
                      ),
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
          Card(
            color: Theme.of(context).colorScheme.surfaceContainer,
            child: ListTile(
              title: Text(
                'A cosa serve Happy@Work',
                style: GoogleFonts.lato(
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Theme.of(context).colorScheme.onSecondaryContainer,
              ),
              onTap: () {},
            ),
          ),
          Card(
            color: Theme.of(context).colorScheme.surfaceContainer,
            child: ListTile(
              title: Text(
                'Chi vede i tuoi dati',
                style: GoogleFonts.lato(
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Theme.of(context).colorScheme.onSecondaryContainer,
              ),
              onTap: () {},
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
          Card(
            color: Theme.of(context).colorScheme.surfaceContainer,
            child: ListTile(
              title: Text(
                'Esci',
                style: GoogleFonts.lato(
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                ),
              ),
              trailing: Icon(
                Icons.exit_to_app,
                color: Theme.of(context).colorScheme.onSecondaryContainer,
              ),
              onTap: logout,
            ),
          ),
        ],
      ),
    );
  }
}
