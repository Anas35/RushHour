import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rush_hour/src/pattern.dart';

import 'dart:ui' as ui;

class WinBox extends ConsumerWidget {
  const WinBox({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final RPattern rPattern = ref.watch(RPattern.rPatternProvider.notifier);
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(0.0),
      child: SizedBox(
        height: 300,
        width: 280,
        child: CustomPaint(
          painter: CustomBox(),
          child: Stack(
            children: [
              Positioned(
                bottom: 25.0,
                child: SizedBox(
                  width: 280.0,
                  height: 75.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(75.0, 75.0),
                          primary: const Color(0xFFBF0000),
                          padding: const EdgeInsets.all(0.0)
                        ),
                        child: const Icon(Icons.restore, size: 36.0), 
                        onPressed: () {
                          rPattern.reset();
                          Navigator.pop(context);
                        },
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(75.0, 75.0),
                          primary: const Color(0xFFBF0000),
                          padding: const EdgeInsets.all(0.0)
                        ),
                        child: const Icon(Icons.shuffle, size: 36.0), 
                        onPressed: () {
                          rPattern.randomPattern();
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomBox extends CustomPainter {
  
  @override
  void paint(Canvas canvas, Size size) {
    
  final Paint _paint1Fill = Paint()
    ..shader = ui.Gradient.linear(
        Offset(size.width, size.height * 0.5),
        Offset(0.0, size.height),
      [
       const Color(0xFFF0E68C),
       const Color(0xFFFFD700), 
      ]
     )
    ..style = PaintingStyle.fill;
    
  final Paint _paint2Fill = Paint()
    ..color = const Color(0xFFBF0000)
    ..style = PaintingStyle.fill;
    
     Path path1 = Path()
       ..moveTo(0.0, size.height * 0.05)
       ..lineTo(0.0, size.height * 0.95)
       ..lineTo(size.width * 0.50, size.height)
       ..lineTo(size.width, size.height * 0.95)
       ..lineTo(size.width, size.height * 0.05)
       ..lineTo(size.width * 0.50, 0)
       ..close();
    
      Path path2 = Path()
        ..moveTo(-size.width * 0.25, size.height * 0.25)
        ..lineTo(size.width * 0.25, size.height * 0.20)
        ..lineTo(size.width * 0.75, size.height * 0.20)
        ..lineTo(size.width + size.width * 0.25, size.height * 0.25)
        ..lineTo(size.width + size.width * 0.25, size.height * 0.35)
        ..lineTo(size.width * 0.50, size.height * 0.50)
        ..lineTo(-size.width * 0.25, size.height * 0.35)
        ..close();
    
      const TextSpan textSpan = TextSpan(
        text: 'VICTORY',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 36,
        ),
      );
      
    final TextPainter textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
    
    textPainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    
    canvas.drawPath(path1, _paint1Fill);
    canvas.drawPath(path2, _paint2Fill);
    textPainter.paint(canvas, Offset(size.width * 0.25, size.height * 0.25));
    
  }

  @override
  bool shouldRepaint(CustomBox oldDelegate) {
    return true;
  }
  
}