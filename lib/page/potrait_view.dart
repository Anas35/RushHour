import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rush_hour/src/pattern.dart';
import 'package:rush_hour/widgets/game_box.dart';
import 'package:rush_hour/page/moves.dart';
import 'package:rush_hour/page/time.dart';


class DrawerChild extends ConsumerWidget {
  const DrawerChild({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(50.0, 50.0),
            ),
            onPressed: () => ref.watch(RPattern.rPatternProvider.notifier).reset(),
            child: const Icon(Icons.restore),
          ),
          const Moves(),
          const Time(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(50.0, 50.0),
            ),
            onPressed: () => ref.watch(RPattern.rPatternProvider.notifier).randomPattern(),
            child: const Icon(Icons.shuffle_sharp),
            //tooltip: 'Generate a Random level',
          ),
        ],
      ),
    );
  }
}

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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Flexible(flex: 1, child: DrawerChild()),
              Expanded(flex: 4, child: Center(child: const GameBox())),
            ],
          ),
        )
      ),
    );
  }
}