import 'package:flutter/material.dart';
import 'package:game/screen.dart';

void main() {
  runApp(SpaceGame());
}

class SpaceGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Space game',
      home: Screen(),
    );
  }
}
