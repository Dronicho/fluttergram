import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  const PostCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
              left: 8.0, right: 4.0, top: 4.0, bottom: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    child: Text('B'),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Text('Name', style: TextStyle(fontWeight: FontWeight.bold))
                ],
              ),
              IconButton(icon: Icon(Icons.more_vert), onPressed: () {})
            ],
          ),
        ),
        Image.network('https://source.unsplash.com/random'),
        Row(
          children: [
            IconButton(icon: Icon(Icons.favorite_border), onPressed: () {}),
            IconButton(icon: Icon(Icons.comment), onPressed: () {}),
            IconButton(icon: Icon(Icons.bookmark), onPressed: () {}),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: Text(
            '3124424 views',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: RichText(
            text: TextSpan(
              text: 'asus_russia ',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              children: [
                TextSpan(
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.normal),
                    text:
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque consectetur nunc ac porttitor laoreet. Aliquam eget magna sollicitudin, tristique nisi in, lacinia tortor. Nullam faucibus turpis et ullamcorper aliquet. Morbi gravida, augue at volutpat venenatis, turpis magna ullamcorper libero, ut sagittis ex lorem at nulla. Donec at ipsum ac sapien tincidunt ullamcorper. Pellentesque vel rutrum quam. Donec non pellentesque lorem, id accumsan eros. Cras lobortis ligula viverra velit accumsan, nec condimentum nibh vulputate. Vestibulum nec risus sit amet enim tempus semper. Suspendisse eleifend dui eget est gravida euismod. Nullam maximus ante non nibh feugiat, vel pretium nulla facilisis. Nunc iaculis velit vel leo dignissim, a pharetra orci faucibus. Nunc ornare suscipit tempus.')
              ],
            ),
          ),
        )
      ],
    );
  }
}
