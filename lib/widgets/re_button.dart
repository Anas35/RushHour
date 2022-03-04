import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rush_hour/src/pattern.dart';

class ReButton extends ConsumerWidget {
  const ReButton({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton.icon(
          onPressed: () => ref.watch(RPattern.rPatternProvider.notifier).reset(),
          icon: const Icon(Icons.restore),
          label: const Text('Reset'),
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(120.0, 45.0),
            primary: const Color(0xFF0A0A0A).withOpacity(0.50),
          ),
        ),
        const SizedBox(height: 100),
        ElevatedButton.icon(
          onPressed: () => ref.watch(RPattern.rPatternProvider.notifier).randomPattern(),
          icon: const Icon(Icons.shuffle),
          label: const Text('Random'),
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(120.0, 45.0),
            primary: const Color(0xFF0A0A0A).withOpacity(0.50),
          ),
        ),
      ],
    );
  }
}