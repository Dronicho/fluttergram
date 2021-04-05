import 'package:flutter/material.dart';

final kDefaultRadius = 50.0;
final kSmallRadius = 35.0;

class StoryWidget extends StatefulWidget {
  const StoryWidget({Key? key}) : super(key: key);

  @override
  _StoryWidgetState createState() => _StoryWidgetState();
}

class _StoryWidgetState extends State<StoryWidget> {
  bool _tapped = false;
  BoxConstraints _normalSize =
      BoxConstraints.loose(Size(kDefaultRadius, kDefaultRadius));
  BoxConstraints _shrinkSize =
      BoxConstraints.loose(Size(kSmallRadius, kSmallRadius));

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        setState(() {
          _tapped = true;
        });
      },
      onLongPress: () {
        setState(() {
          _tapped = false;
        });
        showModalBottomSheet(
          context: context,
          builder: (context) => Container(
              height: MediaQuery.of(context).size.height / 2,
              color: Colors.white),
        );
      },
      onTapUp: (details) {
        setState(() {
          _tapped = false;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 50),
            curve: Curves.easeInOut,
            padding: _tapped ? const EdgeInsets.all(7.5) : EdgeInsets.zero,
            child: AnimatedContainer(
              padding: const EdgeInsets.all(4),
              constraints: _tapped ? _shrinkSize : _normalSize,
              duration: Duration(milliseconds: 50),
              curve: Curves.easeInOut,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Colors.lightGreen),
              child: Container(
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.green),
                child: Center(child: Text('A')),
              ),
            ),
          ),
          Text('name')
        ],
      ),
    );
  }
}
