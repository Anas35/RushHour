import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimeState extends StateNotifier<int> {

  static final timeProvider = StateNotifierProvider<TimeState, int>((ref) => TimeState());
  
  TimeState() : super(0);

  void increment() => state++;

  void reset() => state = 0;

}

class Time extends ConsumerStatefulWidget {
  const Time({Key? key}) : super(key: key);

  @override
  ConsumerState<Time> createState() => _TimeState();
}

class _TimeState extends ConsumerState<Time> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer.periodic(const Duration(seconds: 1), (_) { 
        if(mounted) {
          ref.watch(TimeState.timeProvider.notifier).increment();
        }
      });
    });
  }

  String seconds(int value) {
    final int second = (value % 60);
    if(second.toString().length == 1) {
      return second.toString().padLeft(2, '0');
    } else {
      return second.toString();
    }
  }

  String minutes(int value) {
    final int minute = (value ~/ 60);
    if(minute.toString().length == 1) {
      return minute.toString().padLeft(2, '0');
    } else {
      return minute.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Consumer(
            builder: (context, ref, _) {
              final int value = ref.watch(TimeState.timeProvider);
              String sec = seconds(value), min = minutes(value);
              return Text('$min:$sec', style: const TextStyle(fontSize: 32.0, color: Colors.white));
            }
          ),
          const Text('minutes', style: TextStyle(fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
