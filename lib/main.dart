import 'dart:async';
import 'package:flutter/material.dart';
import 'widgets/Bug.dart';
import 'service/service_locator.dart';
import 'widgets/LoginDialog.dart';
import 'widgets/Score.dart';

void main() {
  setupServiceLocator();
  runApp(MyHome());
}

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Crusher',
        theme:
            ThemeData(primaryColor: Colors.red, accentColor: Colors.redAccent),
        home: Scaffold(
            appBar: AppBar(
              title: const Text('OCP Smasher'),
            ),
            body: MyApp()));
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _crushCount = 0;
  int _start = 40;
  int _starts = 20;
  String _token = '';
  bool flag = true;
  List<Bug> bugs = [];

  late Timer _timer;

  void restartTimer() {
    setState(() {
      _start = 40;
      _starts = 20;
      _crushCount = 0;
      bugs.clear();
    });
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (_start == 0) {
        cancel();
      } else {
        setState(() {
          _start--;
          if (_start.isEven) _starts--;
          bugs.add(new Bug(
            onChanged: (bool crushed) => setState(() {
              _crushCount += 1;
            }),
          ));
        });
      }
    });
  }

  void cancel() {
    setState(() {
      _timer.cancel();
      bugs.clear();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if (flag) {
      Future.delayed(
          Duration.zero,
          () => showDialog(
              context: context,
              builder: (context) => LoginDialog(onChanged: (String t) {
                    _token = t;
                    restartTimer();
                  })));
      flag = false;
    }
    return Stack(
      children: [
        Container(
            child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(32),
              child: Score(
                cancel: cancel,
                crushCount: _crushCount,
                starts: _starts,
                restartTimer: restartTimer,
              ),
            ),
          ],
        )),
        ...bugs
      ],
    );
  }
}
