import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rush_hour/page/block_widget.dart';
import 'package:rush_hour/src/blocks.dart';
import 'package:rush_hour/src/pattern.dart';

class GridPattern extends StatelessWidget {

  final double size;

  const GridPattern({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1.5, color: const Color(0xFF0A0A0A)),
        color: Colors.transparent,
        borderRadius: const BorderRadius.all(Radius.circular(18.0))
      ),
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 6,
        children: List.generate(36, (_) => Container(
            width: size / 6,
            height: size / 6,
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(12.0)),
              border: Border.all(),
              color: const Color(0xFF007991),
            ),
          ),
        ),
      ),
    );
  }
}

class GameBox extends StatelessWidget {

  const GameBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double size = min<double>(constraints.maxWidth, constraints.maxHeight);
        return SizedBox(
          width: size,
          height: size,
          child: Consumer(
            builder: (context, ref, _) {
              Map<String, List<int>> pattern = ref.watch(RPattern.rPatternProvider);
              return Stack(
                  children: [
                  GridPattern(size: size/6),
                  ...pattern.entries.map((entry) {
                    final List<int> listPattern = ref.watch(RPattern.rPatternProvider.select((value) => value[entry.key] ?? []));
                    return Block(
                      key: UniqueKey(),
                      blocks: Blocks(listPattern, size / 6),
                      letter: entry.key, 
                    );
                  },
                ),
              ],
            );
          },
        ),
      );
    });
  }
}
