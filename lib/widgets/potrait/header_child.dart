import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rush_hour/src/pattern.dart';
import 'package:rush_hour/widgets/common/moves.dart';
import 'package:rush_hour/widgets/common/time.dart';

class HeaderChild extends ConsumerWidget {
  const HeaderChild({Key? key }) : super(key: key);

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
          ),
        ],
      ),
    );
  }
}