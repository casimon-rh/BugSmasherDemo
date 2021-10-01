import 'package:flutter/material.dart';

class Score extends StatelessWidget {
  const Score(
      {Key? key,
      required this.crushCount,
      required this.starts,
      required this.restartTimer,
      required this.cancel,
      required this.logout})
      : super(key: key);

  final int crushCount;
  final int starts;
  final Function() restartTimer;
  final Function() cancel;
  final Function() logout;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: [
      Row(children: [
        Icon(
          Icons.bug_report,
          color: Colors.redAccent,
        ),
        Text("$crushCount"),
        const Text(' Bugs Crushed   '),
        Icon(
          Icons.timelapse,
          color: Colors.redAccent,
        ),
        Text(" $starts   "),
        TextButton(
            onPressed: restartTimer,
            child: Row(children: [
              Icon(
                Icons.play_arrow,
                color: Colors.redAccent,
              ),
              const Text(
                " Restart",
                style: TextStyle(color: Colors.black),
              )
            ])),
      ]),
      Row(
        children: [
          TextButton(
              onPressed: cancel,
              child: Row(children: [
                Icon(
                  Icons.stop,
                  color: Colors.redAccent,
                ),
                const Text(
                  " Stop",
                  style: TextStyle(color: Colors.black),
                )
              ])),
          const Text('    '),
          TextButton(
              onPressed: logout,
              child: Row(children: [
                Icon(
                  Icons.logout,
                  color: Colors.redAccent,
                ),
                const Text(
                  " Logout",
                  style: TextStyle(color: Colors.black),
                )
              ]))
        ],
      )
    ]));
  }
}
