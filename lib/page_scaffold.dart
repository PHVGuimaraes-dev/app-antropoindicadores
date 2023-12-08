import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

class PageScaffold extends StatelessWidget {
  final String title;
  final Widget child;

  const PageScaffold({
    super.key,
    required this.title,
    required this.child
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          title: Text(title),
          elevation: 0,
          backgroundColor: Theme.of(context).primaryColor,
          actions: [
            IconButton(
                onPressed: () { AdaptiveTheme.of(context).toggleThemeMode(); },
                icon: const Icon(Icons.brightness_6_outlined)
            ),
          ],
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
          minimum: const EdgeInsets.all(16),
          //child: PageStorage(
            //bucket: PageStorageBucket(),
            child: child,
          //)
      )
    );
  }
}