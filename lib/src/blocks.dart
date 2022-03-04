import 'package:rush_hour/src/pair.dart';

class Blocks {

  final List<int> block;
  final double size;

  Blocks(this.block, this.size);

  bool get isHorizontalBlock => block[1] - block[0] == 1;

  bool get isTwoBlock => block.length == 2;
  
  Pair<double> get getSize {
    if (isHorizontalBlock) {
      return Pair<double>(block.length * size, size);
    } else {
      return Pair<double>(size, block.length * size);
    }
  }

  Pair<double> get initialPosition => Pair<double>((block.first % 6) * size, (block.first ~/ 6) * size);
}