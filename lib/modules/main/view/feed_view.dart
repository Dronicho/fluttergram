import 'package:flutter/material.dart';
import 'package:fluttergram/modules/main/widgets/widgets.dart';

class FeedView extends StatelessWidget {
  const FeedView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child:
                    Row(children: List.generate(10, (index) => StoryWidget())),
              )),
          ...List.generate(10, (index) => PostCard())
        ],
      ),
    );
  }
}
