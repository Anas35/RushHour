import 'package:flutter/material.dart';
import 'package:rush_hour/widgets/common/game_box.dart';
import 'package:rush_hour/widgets/common/moves.dart';
import 'package:rush_hour/widgets/landscape/re_button.dart';
import 'package:rush_hour/widgets/common/time.dart';
import 'package:rush_hour/widgets/landscape/shadow_container.dart';

class LandscapeView extends StatelessWidget {
  const LandscapeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Rush Hour'),
        centerTitle: true,
        foregroundColor: const Color(0xFF0A0A0A),
        backgroundColor: const Color(0xFF007991),
        elevation: 8.0,
      ),
      body: const SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: SizedBox(
          height: 500,
          child: Center(
            child: SizedBox(
                width: 750.0,
                height: 750.0,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ShadowContainer(child: Moves()),
                            SizedBox(width: 100, height: 100),
                            ShadowContainer(child: Time())
                          ],
                        ),
                      ),
                      Expanded(flex: 5, child: GameBox()),
                      Expanded(flex: 2, child: ReButton()),
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
