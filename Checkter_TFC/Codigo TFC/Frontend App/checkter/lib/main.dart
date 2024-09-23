import 'package:checkter/Pages/Inicio.dart';
import 'package:checkter/Pages/Menu.dart';
import 'package:checkter/Pages/Review.dart';
import 'package:flutter/material.dart';
import 'Pages/Game.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      initialRoute: '/inicio',
      routes: {
        '/inicio': (context) => const Inicio(),
        '/menu': (context) => const Menu(),
        '/game': (context) => const Game(),
        '/review': (context) => const Review(),
      },
    );
  }
}
