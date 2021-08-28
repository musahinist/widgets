import 'package:flutter/material.dart';

import 'gesture_matrix.dart';

class ScalePanRotate extends StatefulWidget {
  const ScalePanRotate({Key? key}) : super(key: key);

  @override
  _ScalePanRotateState createState() => _ScalePanRotateState();
}

class _ScalePanRotateState extends State<ScalePanRotate> {
  Matrix4 matrix = Matrix4.identity();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MatrixGestureDetector(
        onMatrixUpdate: (m, tm, sm, rm) {
          setState(() {
            matrix = m;
          });
        },
        child: Transform(
          transform: matrix,
          child: Container(
            child: Image.network(
                'https://upload.wikimedia.org/wikipedia/commons/thumb/1/12/User_icon_2.svg/2048px-User_icon_2.svg.png'),
          ),
        ),
      ),
    );
  }
}
