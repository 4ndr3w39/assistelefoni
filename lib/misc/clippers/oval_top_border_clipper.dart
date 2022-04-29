import 'package:flutter/rendering.dart';

class OvalTopBorderClipper extends CustomClipper<Path> {
  final double depth;

  OvalTopBorderClipper({this.depth = 30});

  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0, depth);
    path.quadraticBezierTo(size.width / 4, 0, size.width / 2, 0);
    path.quadraticBezierTo(size.width - size.width / 4, 0, size.width, depth);

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
