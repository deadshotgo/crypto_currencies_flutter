import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lessons/router/router.dart';
import 'package:lessons/theme/theme.dart';
import 'package:talker_flutter/talker_flutter.dart';
class CryptoCurrenciesApp extends StatelessWidget {
  const CryptoCurrenciesApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crypto currencies',
      theme: darkTheme,
      routes: routes,
      navigatorObservers: [
        TalkerRouteObserver(GetIt.I<Talker>())
      ],
    );
  }
}