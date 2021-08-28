import 'package:flutter/material.dart';
import 'package:play/animation/glassy.dart';
import 'package:play/interactivity/matrix_gesture/scale_pan_rotate.dart';
import 'package:play/sound/sound_player.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Editor(),
    );
  }
}
