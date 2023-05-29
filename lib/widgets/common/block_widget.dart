import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rush_hour/src/blocks.dart';
import 'package:rush_hour/src/pattern.dart';
import 'package:rush_hour/widgets/common/win_box.dart';


class Block extends StatefulWidget {
  
  final Blocks blocks;
  final String letter;

  const Block({Key? key, required this.blocks, required this.letter}) : super(key: key);

  @override
  _BlockState createState() => _BlockState();
}

class _BlockState extends State<Block> with SingleTickerProviderStateMixin {
  late Blocks blocks;

  late AnimationController animationController;
  late Animation<double> animation;

  late double value;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this);

    blocks = widget.blocks;

    value = blocks.isHorizontalBlock
        ? blocks.initialPosition.first
        : blocks.initialPosition.last;

    animationController.addListener(() {
      setState(() {
        value = animation.value;
      });
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void updatePan(DragUpdateDetails details, RPattern rPattern) {
    Offset offset = details.delta;
    Pair limit = rPattern.limitedPosition(widget.letter, widget.blocks.size);

    setState(() {
      if (blocks.isHorizontalBlock) {
        if (value + offset.dx >= limit.first &&
            value + offset.dx <= limit.last) {
          value += offset.dx;
        }
      } else {
        if (value + offset.dy >= limit.first &&
            value + offset.dy <= limit.last) {
          value += offset.dy;
        }
      }
    });
  }

  void endPan(DragEndDetails details, RPattern rPattern) {
    setState(() => value = (value / blocks.size).round() * blocks.size);
    rPattern.changeIndex(widget.letter, value, widget.blocks.size);  
    if(rPattern.isWon(widget.letter)) {
      showDialog(context: context, builder: (_) => const WinBox());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: blocks.isHorizontalBlock ? blocks.initialPosition.last : value,
      left: blocks.isHorizontalBlock ? value : blocks.initialPosition.first,
      child: Consumer(
        child: Container(
          width: blocks.getSize.first,
          height: blocks.getSize.last,
          decoration: BoxDecoration(image: getImage()),
        ),
        builder: (context, ref, child) {
        final RPattern rPattern = ref.watch(RPattern.rPatternProvider.notifier);
        return GestureDetector(
          onPanUpdate: (details) => updatePan(details, rPattern),
          onPanEnd: (details) => endPan(details, rPattern),
          child: child
        );
      }),
    );
  }

  DecorationImage getImage() {
    if(blocks.isHorizontalBlock) {
      return DecorationImage(
        fit: BoxFit.fill,
        image: (() {
          if(blocks.isTwoBlock) {
            return widget.letter == 'A' ? const AssetImage('images/m.png') : const AssetImage('images/b_hori.png');
          } else {
            return const AssetImage('images/t_hori.png');
          }
        }())
      );
    } else {
      return DecorationImage(
        fit: BoxFit.fill,
        image: blocks.isTwoBlock ? const AssetImage('images/b_verti.png') : const AssetImage('images/t_verti.png')
      );
    }
  }
}
