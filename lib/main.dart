import 'dart:async';
import 'package:flutter/material.dart';
import './BugWidget.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _crushCount = 0;
  int _start = 40;
  int _starts = 20;

  List<BugWidget> bugs = [];

  late Timer _timer;

  void _reduce(int numb) {
    _start--;
    if (numb.isEven) _starts--;
    bugs.add(new BugWidget(
      onChanged: _crush,
    ));
  }

  void restartTimer() {
    setState(() {
      _start = 40;
      _starts = 20;
      _crushCount = 0;
    });
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (_start == 0) {
        setState(() {
          timer.cancel();
          bugs.clear();
        });
      } else {
        setState(() => _reduce(_start));
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _crush(bool crushed) => setState(() {
        _crushCount += 1;
      });

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Widget scoreSection = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Icon(
            Icons.bug_report,
            color: Colors.blueAccent,
          ),
          Text("$_crushCount"),
          const Text(' Bugs Crushed | | '),
          Text("$_starts "),
          TextButton(onPressed: restartTimer, child: const Text("Reiniciar"))
        ],
      ),
    );
    return MaterialApp(
        title: 'Crusher',
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Bug crushing'),
            ),
            body: Stack(
              children: [
                Container(
                  child: Column(
                    children: [scoreSection],
                  ),
                ),
                ...bugs
              ],
            )));
  }
}
