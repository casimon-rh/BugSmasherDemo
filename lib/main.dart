import 'dart:async';
import 'package:flutter/material.dart';
import 'dto/Request.dart';
import 'service/OcpService.dart';
import 'dto/Pod.dart';
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
  String _token = "";
  String _url = "";
  bool flag = true;
  List<Bug> bugs = [];
  OcpService service = getIt<OcpService>();

  late Timer _timer;

  void restartTimer() async {
    setState(() {
      _start = 40;
      _starts = 20;
      _crushCount = 0;
      bugs.clear();
    });
    List<Pod> pods = await service.getPods(_url, _token);
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (_start == 0) {
        cancel();
      } else {
        int lastlenght = bugs.length - 1;
        int index = lastlenght >= 0 ? lastlenght : 0;
        while (pods.length <= index) {
          index = index - pods.length;
        }
        setState(() {
          _start--;
          if (_start.isEven) _starts--;
          bugs.add(new Bug(
            pod: pods[index],
            onChanged: (Pod pod) => setState(() {
              _crushCount += 1;
              service.deletePod(_url, _token, pod.name);
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

  void createDialog() {
    Future.delayed(
        Duration.zero,
        () => showDialog(
            context: context,
            builder: (context) => LoginDialog(onChanged: (Request t) {
                  _token = t.token;
                  _url = t.url;
                  restartTimer();
                })));
  }

  void logout() {
    cancel();
    setState(() {
      _token = "";
    });
    createDialog();
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
      createDialog();
      flag = false;
    }
    return Stack(
      children: [
        Container(
            child: Column(
          children: [
            Row(children: [
              Container(
                padding: const EdgeInsets.all(32),
                child: Score(
                  cancel: cancel,
                  crushCount: _crushCount,
                  starts: _starts,
                  restartTimer: restartTimer,
                  logout: logout,
                ),
              )
            ])
          ],
        )),
        ...bugs
      ],
    );
  }
}
