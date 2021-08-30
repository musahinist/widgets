import 'package:flutter/material.dart';

class Editor extends StatefulWidget {
  const Editor({Key? key}) : super(key: key);

  @override
  _EditorState createState() => _EditorState();
}

class _EditorState extends State<Editor> {
  List<Sticker> items = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          items.add(Sticker(
            key: UniqueKey(),
            onTap: (sticker) {
              items.remove(sticker);
              items.add(sticker);

              setState(() {});
            },
          ));
          setState(() {});
        },
      ),
      body: Stack(children: [
        Center(),
        ...List.generate(items.length, (index) => items[index]),
      ]),
    );
  }
}

class Sticker extends StatefulWidget {
  final ValueSetter<Sticker> onTap;
  Sticker({Key? key, required this.onTap}) : super(key: key);

  @override
  _StickerState createState() => _StickerState();
}

class _StickerState extends State<Sticker> {
  Offset _offset = Offset.zero;
  Offset _initialFocalPoint = Offset.zero;
  Offset _sessionOffset = Offset.zero;

  double _scale = 1;
  double _angle = 0.0;
  double _initialScale = 1;
  double _initialAngle = 0.0;
  bool visible = true;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Visibility(
        visible: visible,
        child: Transform.translate(
          offset: _offset + _sessionOffset,
          child: Stack(
            children: [
              SizedBox(
                height: 100,
                width: 100,
                child: GestureDetector(
                  onTap: () {
                    widget.onTap(widget);
                  },
                  onLongPress: () {
                    visible = false;
                    setState(() {});
                  },
                  onScaleStart: (details) {
                    widget.onTap(widget);
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
