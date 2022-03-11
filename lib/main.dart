import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rush_hour/widgets/landscape/landscape_view.dart';
import 'package:rush_hour/widgets/potrait/potrait_view.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Rush Hour',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {

  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff007991),
            Color(0xff78ffd6),
          ],
        ),
      ),
      child: Builder(
        builder: (context) {
          Orientation orientation = MediaQuery.of(context).orientation;
          Size size = MediaQuery.of(context).size;
          if(orientation == Orientation.portrait || size.width < 600.0) {
            return const PotraitView();
          } else {
            return const LandscapeView();
          }
        }
      ),
    );
  }
}
