import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'keynest_theme.dart';
import 'router.dart';

class KeyNestApp extends StatelessWidget {
  const KeyNestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'KeyNest',
      debugShowCheckedModeBanner: false,
      theme: KeyNestTheme.light(),
      locale: const Locale('zh', 'CN'),
      supportedLocales: const [Locale('zh', 'CN')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      routerConfig: keynestRouter,
    );
  }
}
