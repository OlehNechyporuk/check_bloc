
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          '${AppLocalizations.of(context)?.splashPageText}',
          style: const TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}
