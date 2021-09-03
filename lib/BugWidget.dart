import 'dart:math';

import 'package:flutter/material.dart';

class BugWidget extends StatefulWidget {
  const BugWidget({
    Key? key,
    this.isCrushed = false,
    required this.onChanged,
  }) : super(key: key);

  final bool isCrushed;
  final ValueChanged<bool> onChanged;

  @override
  _BugWidgetState createState() => _BugWidgetState();
}

class _BugWidgetState extends State<BugWidget>
    with SingleTickerProviderStateMixin {
  bool isCrushed = false;
  final int random = Random().nextInt(5) + 1;
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  )..forward();

  void _crush() {
    if (!isCrushed) widget.onChanged(isCrushed);
    setState(() {
      if (!isCrushed) isCrushed = true;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double smallLogo = 200;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final Size biggest = constraints.biggest;
        final double middle = biggest.width / 2 - smallLogo;
        final double randomWidth = biggest.width / random - smallLogo;
        return Stack(
          children: <Widget>[
            PositionedTransition(
              rect: RelativeRectTween(
                begin: RelativeRect.fromSize(
                    Rect.fromLTWH(randomWidth, 0, smallLogo, smallLogo),
                    biggest),
                end: RelativeRect.fromSize(
                    Rect.fromLTWH(randomWidth, biggest.height + smallLogo,
                        smallLogo, smallLogo),
                    biggest),
              ).animate(CurvedAnimation(
                parent: _controller,
                curve: Curves.linear,
              )),
              child: Padding(
                  padding: EdgeInsets.all(8),
                  child: ElevatedButton(
                      onPressed: _crush,
                      style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                          shadowColor: Colors.transparent),
                      child: Image.asset(
                          isCrushed ? 'images/fire.png' : 'images/bug.png',
                          width: 200,
                          height: 200,
                          fit: BoxFit.fill))),
            ),
          ],
        );
      },
    );
  }
}
