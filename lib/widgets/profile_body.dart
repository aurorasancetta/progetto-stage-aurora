import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_at_work/api/microsoft_auth.dart';
import 'package:happy_at_work/providers/user_provider.dart';
import 'package:happy_at_work/widgets/info/data_use.dart';
import 'package:happy_at_work/widgets/info/utility.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileBody extends ConsumerWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    // inserire url sondaggio
    final Uri url = Uri.parse('https://forms.office.com/e/DN2vUBncPj');
    Future<void> openUrl() async {
      if (!await launchUrl(url)) {
        throw Exception('Errore | non sono riuscito ad aprire il sito $url');
      }
    }

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
                Icon(
                  Icons.account_circle,
                  size: 80,
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                ),
                const SizedBox(width: 16),
                Text(
                  user.nameSurname,
                  style: GoogleFonts.lato(
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
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
              onTap: () => showDialog(
                context: context,
                builder: (BuildContext ctx) => const Utility(),
              ),
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
              onTap: () => showDialog(
                context: context,
                builder: (BuildContext ctx) => const DataUse(),
              ),
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
                'Invia un feedback',
                style: GoogleFonts.lato(
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                ),
              ),
              trailing: Icon(
                Icons.send,
                color: Theme.of(context).colorScheme.onSecondaryContainer,
              ),
              onTap: openUrl,
            ),
          ),
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
