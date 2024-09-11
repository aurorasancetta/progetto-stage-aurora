import 'package:flutter/material.dart';
import 'package:happy_at_work/screens/shared.dart';

class MainScreenScaffold extends StatelessWidget {
  const MainScreenScaffold({
    super.key,
    required this.body,
    required this.navigationType,
    required this.onNavigationTypeSelected,
  });

  final Widget body;
  final MainScreenScaffoldNavigationType navigationType;
  final void Function(MainScreenScaffoldNavigationType)
      onNavigationTypeSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: body,
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          onNavigationTypeSelected(index == 0
              ? MainScreenScaffoldNavigationType.sentiment
              : MainScreenScaffoldNavigationType.profile);
        },
        selectedIndex:
            navigationType == MainScreenScaffoldNavigationType.sentiment
                ? 0
                : 1,
        destinations: [
          NavigationDestination(
              enabled:
                  navigationType != MainScreenScaffoldNavigationType.sentiment,
              icon: const Icon(Icons.emoji_emotions),
              label: 'Sentiment'),
          NavigationDestination(
              enabled:
                  navigationType != MainScreenScaffoldNavigationType.profile,
              icon: const Icon(Icons.account_circle),
              label: 'Profilo'),
        ],
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
    );
  }
}
