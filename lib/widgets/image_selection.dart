import 'package:flutter/material.dart';

class ImageSelection extends StatelessWidget {
  final List<String> _availableAvatars = [
    'images/dothraki_avatar.jpg',
    'images/girl_avatar.jpg',
    'images/guy_avatar.jpg',
    'images/magic_avatar.jpg',
    'images/soldier_avatar.jpg',
    'images/witch_avatar.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 2,
          crossAxisSpacing: 8,
          childAspectRatio: 3 / 2,
        ),
        itemBuilder: (ctx, index) {
          return Image.asset(_availableAvatars[index]);
        },
        itemCount: 6);
  }
}
