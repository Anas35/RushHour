import 'package:flutter/material.dart';
import 'package:rush_hour/widgets/common/game_box.dart';
import 'package:rush_hour/widgets/potrait/header_child.dart';

class PotraitView extends StatelessWidget {

  const PotraitView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Rush Hour'),
        centerTitle: true,
        foregroundColor: const Color(0xFFFFFFFF),
        backgroundColor: const Color(0xFF007991),
        elevation: 8.0,
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Flexible(flex: 1, child: HeaderChild()),
              Expanded(flex: 4, child: Center(child: GameBox())),
            ],
          ),
        )
      ),
    );
  }
}