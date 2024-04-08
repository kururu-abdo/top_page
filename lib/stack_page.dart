import 'package:flutter/material.dart';

class StackPage extends StatefulWidget {
  const StackPage({super.key});

  @override
  State<StackPage> createState() => _StackPageState();
}

class _StackPageState extends State<StackPage> {
  // 1.
var _x = 0.0;
var _y = 180.0;
final GlobalKey stackKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(

body: SizedBox.expand(
  child: 
  Stack( // 2.
      key: stackKey, // 3.
      fit: StackFit.expand,
      children: [
        
        Container(color: Colors.blue), // 4.
        Positioned( // 5.
          left: _x,
          top: _y,
          child: Draggable( // 6.
            feedback: const Text('Move me'), // 8.
            childWhenDragging: Container(), // 9.
            onDragEnd: (dragDetails) { // 10.
              setState(() {
                final parentPos = stackKey.globalPaintBounds;
                if (parentPos == null) return;
                _x = dragDetails.offset.dx - parentPos.left; // 11.
                _y = dragDetails.offset.dy - parentPos.top;
              });
            }, // 6.
            child: const Text('Move me'),
          ),
        ),
      ],
    ),
),
    );
  }

  
}

extension GlobalKeyExtension on GlobalKey {
  Rect? get globalPaintBounds {
    final renderObject = currentContext?.findRenderObject();
    var translation = renderObject?.getTransformTo(null).getTranslation();
    if (translation != null && renderObject?.paintBounds != null) {
      return renderObject!.paintBounds
          .shift(Offset(translation.x, translation.y));
    } else {
      return null;
    }
  }
}