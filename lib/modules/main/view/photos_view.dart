import 'package:flutter/material.dart';

class UserPhotosView extends StatelessWidget {
  const UserPhotosView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, mainAxisSpacing: 5.0, crossAxisSpacing: 5.0),
      itemBuilder: (context, index) => Container(
        height: 100,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage('https://source.unsplash.com/random'))),
      ),
      itemCount: 12,
    );
  }
}
