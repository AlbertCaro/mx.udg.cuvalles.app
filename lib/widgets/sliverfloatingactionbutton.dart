import 'package:flutter/material.dart';

class SliverFloatingActionButton extends StatelessWidget {
  SliverFloatingActionButton({this.scrollController, this.child, this.onPressed});

  final ScrollController scrollController;
  final Widget child;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    final double defaultTopMargin = 256.0 - 4.0;
    final double scaleStart = 96.0;
    final double scaleEnd = scaleStart / 2;
    double top = 256.0 - 4.0;
    double scale = 1.0;

    if (scrollController.hasClients) {
      double offset = scrollController.offset;
      top -= offset;
      if (offset < defaultTopMargin - scaleStart)
        scale = 1.0;
      else if (offset < defaultTopMargin - scaleEnd)
        scale = (defaultTopMargin - scaleEnd - offset) / scaleEnd;
      else
        scale = 0.0;
    }
    
    return Positioned(
      top: top,
      right: 16.0,
      child: Transform(
        transform: Matrix4.identity()..scale(scale),
        alignment: Alignment.center,
        child: FloatingActionButton(
          onPressed: onPressed,
          child: child,
        ),
      ),
    );
  }

}