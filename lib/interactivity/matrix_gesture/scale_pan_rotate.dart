import 'package:flutter/material.dart';

class ScalePanRotate extends StatefulWidget {
  const ScalePanRotate({Key? key}) : super(key: key);

  @override
  _ScalePanRotateState createState() => _ScalePanRotateState();
}

class _ScalePanRotateState extends State<ScalePanRotate> {
  Offset _offset = Offset.zero;
  Offset _initialFocalPoint = Offset.zero;
  Offset _sessionOffset = Offset.zero;

  double _scale = 1.0;
  double _angle = 0.0;
  double _initialScale = 1.0;
  double _initialAngle = 0.0;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: _offset + _sessionOffset,
      child: GestureDetector(
        onScaleStart: (details) {
          _initialFocalPoint = details.focalPoint;
          _initialScale = _scale;
          _initialAngle = _angle;
        },
        onScaleUpdate: (details) {
          setState(() {
            _sessionOffset = details.focalPoint - _initialFocalPoint;
            _scale = _initialScale * details.scale;
            _angle = _initialAngle + details.rotation;
          });
        },
        onScaleEnd: (details) {
          setState(() {
            _offset += _sessionOffset;
            _sessionOffset = Offset.zero;
          });
        },
        child: Transform.scale(
          scale: _scale,
          child: Transform.rotate(
            angle: _angle,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Image.network(
                  "https://upload.wikimedia.org/wikipedia/commons/thumb/1/12/User_icon_2.svg/2048px-User_icon_2.svg.png"),
            ),
          ),
        ),
      ),
    );
  }
}
