import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/material.dart';

class Glassy extends StatefulWidget {
  const Glassy({Key? key}) : super(key: key);

  @override
  _GlassyState createState() => _GlassyState();
}

class _GlassyState extends State<Glassy> with SingleTickerProviderStateMixin {
  late AnimationController _controller = AnimationController(
    duration: Duration(milliseconds: 300),
    vsync: this,
  )..addListener(() {
      if (_controller.status == AnimationStatus.completed) {
        visible = !visible;
        _controller.reverse();

        setState(() {});
      } else {
        setState(() {});
      }
    });
  late Animation<double> animation;
  bool visible = false;

  List<Widget> children = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    animation = Tween<double>(begin: -.3, end: 1).animate(_controller);
  }

  void swapOrder() {
    Widget _first = children[0];
    children.removeAt(0);
    children.add(_first);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[900],
      body: Stack(
        //   fit: StackFit.expand,
        children: [
          Center(
            child: Container(
              height: 100,
              width: double.maxFinite,
              color: Colors.purple,
            ),
          ),
          Center(
            child: Container(
              // width: 200,
              //  alignment: Alignment.topCenter,
              height: 310,
              width: 200,

              child: Stack(
                children: [
                  if (visible)
                    Align(
                      alignment: Alignment(0, animation.value),
                      child: Card(
                        elevation: 0,
                        color: Colors.amber,
                        child: Padding(
                          padding: const EdgeInsets.all(48.0),
                          child: Text('Button'),
                        ),
                      ),
                    ),
                  GestureDetector(
                    onTap: () {
                      if (_controller.status == AnimationStatus.completed) {
                        _controller.reverse();
                      } else {
                        _controller.forward();
                      }

                      //  setState(() {});
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 10.0,
                          sigmaY: 10.0,
                        ),
                        child: Container(
                          width: 200,
                          height: 200,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.purple[400]!),
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                  ),
                  if (!visible)
                    Align(
                      alignment: Alignment(0, animation.value),
                      child: Card(
                        color: Colors.amber,
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(48.0),
                          child: Text('Button'),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
