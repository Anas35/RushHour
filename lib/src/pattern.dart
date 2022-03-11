import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rush_hour/src/config.dart';
import 'package:rush_hour/widgets/common/moves.dart';
import 'package:rush_hour/widgets/common/time.dart';

class RPattern extends StateNotifier<Map<String, List<int>>> {

  final StateNotifierProviderRef ref;

  static final rPatternProvider = StateNotifierProvider<RPattern, Map<String, List<int>>>((ref) {
    return RPattern(ref);
  });

  RPattern(this.ref) : super(Pattern.convertPatternToMap());

  void reset() {
    if(Pattern.oldState.isNotEmpty) {
      state = Map.from(Pattern.oldState);
      ref.watch(MoveState.moveProvider.notifier).reset();
      ref.watch(TimeState.timeProvider.notifier).reset();
    }
  }

  void randomPattern() {
    state = Pattern.convertPatternToMap();
    ref.watch(MoveState.moveProvider.notifier).reset();
    ref.watch(TimeState.timeProvider.notifier).reset();
  }

  void changeIndex(String letter, num value, double size) {
    List<int> metablock = state[letter] ?? [];
    List<int> newList = [];
    
    if(metablock[1] - metablock[0] == 1) {
      if(value ~/ size > metablock.first % 6) {
      int newValue = (value ~/ size) - (metablock.first % 6);
      
      int first = metablock.first + newValue;
      
      for(int i = 0; i < metablock.length; i++) {
        newList.add(first + i);
      }      
    } else if(value ~/ size < metablock.first % 6) {
      int newValue = (metablock.first % 6) - (value ~/ size);
      
      int first = metablock.first - newValue;
      
      for(int i = 0; i < metablock.length; i++) {
        newList.add(first + i);
      }      
    }
   } else {
      int oldV = metablock.first ~/ 6;
      int newV = value ~/ size;
      
      if(newV > oldV) {
        int first = metablock.first + ((newV - oldV) * 6);
        for(int i = 0; i < metablock.length; i++) {
          newList.add(first + (i * 6));
        }
      } else if (newV < oldV) {
        int first = metablock.first - ((oldV - newV) * 6);
        for(int i = 0; i < metablock.length; i++) {
          newList.add(first + (i * 6));
        }
      }
    }
    if(newList.isNotEmpty) {
      ref.watch(MoveState.moveProvider.notifier).increment();
      state[letter] = newList;
    }
  }

  List<int> _getAllBlock(String char) {
    List<int> currentBlock = [];
    state.forEach((key, value) {
      if(key != char) {
        currentBlock.addAll(state[key] ?? []);
      }
    });
    return currentBlock;
  }

  List<double> limitedPosition(String char, double size) {

    List<int> block = state[char] ?? [];

    double sub = size * block.length;

    double first = 0.0;
    double second = size * 6 - sub;
    
     List<int> blockIndex = _getAllBlock(char);
    
    if(block[1] - block[0] == 1) {
      int front = block.first - (block.first % 6);
      int end = ((block.last ~/ 6) + 1) * 6;

      for (int i = front; i < block.first; i++) {
        if(blockIndex.contains(i)) {
          first = ((i + 1) % 6) * size;
        }  
      }

      for (int i = end - 1; i > block.last; i--) {
        if(blockIndex.contains(i)) {
           second = ((i % 6) * size) - sub;
        }        
      }

      return [first, second];
    } else {

      for (int i = 0 + (block.first % 6); i < block.first; i+=6) {
          if(blockIndex.contains(i)) {
            first = ((i ~/ 6) + 1) * size;
          }
      }

      for (int i = 30 + (block.first % 6); i > block.last; i-=6) {
        if(blockIndex.contains(i)) {
            second = ((i ~/ 6) * size) - sub;
         }    
      }
      
      return [first, second];
    }
  }

  bool isWon(String letter) {
    final List<int> block = state[letter] ?? [];
    if(block[1] - block[0] == 1 && block.last == 17) {
      return true;
    } else {
      return false;
    }
  }

}


class Pattern {

  static Map<String, List<int>> oldState = {};

  static Map<String, List<int>> convertPatternToMap() {
    Map<String, List<int>> convertedMap = {};

    List<int> shuffled = List<int>.generate(50, (index) => index)..shuffle();

    if(shuffled.isEmpty) {
      shuffled = List<int>.generate(50, (index) => index)..shuffle();
    }

    String pattern = configuration[shuffled.removeLast()];

    for (int i = 0; i < pattern.length; i++) {
      String letter = pattern[i];
      if(letter != 'o') {
        convertedMap[letter] == null ? convertedMap[letter] = [i] : convertedMap[letter]!.add(i);
      }
    }

    oldState = Map.from(convertedMap);

    return convertedMap;
  }
}