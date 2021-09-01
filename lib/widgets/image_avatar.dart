import 'dart:math';

import 'package:flutter/material.dart';

class ImageAvatar extends StatefulWidget {
  @override
  _ImageAvatarState createState() => _ImageAvatarState();
}

class _ImageAvatarState extends State<ImageAvatar> {
  late Image _bgImage;

  @override
  void initState() {
    final availableAvatars = [
      Image.asset('images/dothraki_avatar.jpg'),
      Image.asset('images/girl_avatar.jpg'),
      Image.asset('images/guy_avatar.jpg'),
      Image.asset('images/magic_avatar.jpg'),
      Image.asset('images/soldier_avatar.jpg'),
      Image.asset('images/witch_avatar.jpg'),
    ];

    _bgImage = availableAvatars[Random().nextInt(6)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _bgImage,
    );
  }
}
