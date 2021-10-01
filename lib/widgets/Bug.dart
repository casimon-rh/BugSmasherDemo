import 'dart:math';

import 'package:flutter/material.dart';
import '../dto/Pod.dart';

class Bug extends StatefulWidget {
  const Bug(
      {Key? key,
      this.isCrushed = false,
      required this.onChanged,
      required this.pod})
      : super(key: key);

  final bool isCrushed;
  final ValueChanged<Pod> onChanged;
  final Pod pod;

  @override
  _BugState createState() => _BugState(pod: pod);
}

class _BugState extends State<Bug> with SingleTickerProviderStateMixin {
  _BugState({required this.pod}) : super();
  final Pod pod;
  final int random = Random().nextInt(6);
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  )..forward();

  void _crush() {
    if (pod.isRunning) {
      setState(() {
        pod.isRunning = false;
      });
      widget.onChanged(pod);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double smallLogo = 100;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final Size biggest = constraints.biggest;
        final double randomWidth = (biggest.width / 4 - smallLogo / 2) * random;
        return Stack(
          children: <Widget>[
            PositionedTransition(
              rect: RelativeRectTween(
                begin: RelativeRect.fromSize(
                    Rect.fromLTWH(randomWidth, smallLogo, smallLogo, smallLogo),
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
                          pod.isRunning ? 'images/bug.png' : 'images/fire.png',
                          width: smallLogo,
                          height: smallLogo,
                          fit: BoxFit.fill))),
            ),
          ],
        );
      },
    );
  }
}
