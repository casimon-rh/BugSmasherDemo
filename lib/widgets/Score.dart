import 'package:flutter/material.dart';

class Score extends StatelessWidget {
  const Score(
      {Key? key,
      this.crushCount = 0,
      this.starts = 0,
      this.restartTimer,
      this.cancel})
      : super(key: key);

  final int crushCount;
  final int starts;
  final Function()? restartTimer;
  final Function()? cancel;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      children: [
        Icon(
          Icons.bug_report,
          color: Colors.redAccent,
        ),
        Text("$crushCount"),
        const Text(' Bugs Crushed '),
        Icon(
          Icons.timelapse,
          color: Colors.redAccent,
        ),
        Text(" $starts   "),
        TextButton(
            onPressed: restartTimer,
            child: const Text(
              "▶ Reiniciar",
              style: TextStyle(color: Colors.redAccent),
            )),
        const Text('    '),
        TextButton(
            onPressed: cancel,
            child: const Text(
              "⏹ Parar",
              style: TextStyle(color: Colors.redAccent),
            ))
      ],
    ));
  }
}
