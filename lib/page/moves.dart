import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MoveState extends StateNotifier<int> {

  static final moveProvider = StateNotifierProvider<MoveState, int>((ref) => MoveState());
  
  MoveState() : super(0);

  void increment() => state++;

  void reset() => state = 0;

}

class Moves extends StatelessWidget {
  const Moves({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Consumer(
            builder: (context, ref, __) {
              final int moveCount = ref.watch(MoveState.moveProvider);
              return Text(moveCount.toString(), style: const TextStyle(fontSize: 32.0, color: Colors.white));
            }
          ),
          const Text('moves', style: TextStyle(fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
