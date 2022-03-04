import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rush_hour/src/pattern.dart';

class WinBox extends ConsumerWidget {
  const WinBox({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final RPattern rPattern = ref.watch(RPattern.rPatternProvider.notifier);
    return AlertDialog(
      title: const Text('You Won'),
      actions: [
        ElevatedButton(
          onPressed: () {
            rPattern.reset();
            Navigator.of(context).pop();
          },
          child: const Text('Play Again'),
        ),
        ElevatedButton(
          onPressed: () {
            rPattern.randomPattern();
            Navigator.of(context).pop();
          },
          child: const Text('Next level'),
        ),
      ],
    );
  }
}