typedef Pair = ({double first, double last});

class Blocks {

  final List<int> block;
  final double size;

  Blocks(this.block, this.size);

  bool get isHorizontalBlock => block[1] - block[0] == 1;

  bool get isTwoBlock => block.length == 2;
  
  Pair get getSize {
    if (isHorizontalBlock) {
      return (first: block.length * size, last: size);
    } else {
      return (first: size, last: block.length * size);
    }
  }

  Pair get initialPosition => (
    first: (block.first % 6) * size,
    last: (block.first ~/ 6) * size,
  );
}