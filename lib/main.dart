import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tomate Clock',
      home: Scaffold(
        backgroundColor: Color(0xFFF6F6F6),
        appBar: AppBar(
          centerTitle: true,
          title: Text('Tomate Clock'),
        ),
        body: Center(
          child: TomateClock(),
        ),
      ),
    );
  }
}

class TomateClock extends StatefulWidget {
  @override
  _TomateClockState createState() => _TomateClockState();
}

class _TomateClockState extends State<TomateClock> {
  CountDownController _countDownController = CountDownController();
  int duration = 10; //1500 for 25 minutes
  bool _isRunning = false;
  String buttonText = 'Start';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularCountDownTimer(
          width: 300,
          height: 300,
          duration: duration,
          isReverse: true,
          autoStart: false,
          controller: _countDownController,
          fillColor: Color(0xFFE63E3E),
          ringColor: Color(0xFF333333),
          onStart: () => _isRunning = true,
          onComplete: () => {_isRunning = false, buttonText = 'Start'},
        ),
        SizedBox(
          height: 100,
        ),
        ElevatedButton(
          onPressed: () => {startCountDown(_countDownController, _isRunning)},
          child: Text(buttonText),
        ),
      ],
    );
  }

  void startCountDown(CountDownController _controller, bool state) {
    setState(() {
      switch (buttonText) {
        case 'Start':
          _controller.start();
          buttonText = 'Pause';
          break;
        case 'Pause':
          _controller.pause();
          buttonText = 'Resume';
          break;
        case 'Resume':
          _controller.resume();
          buttonText = 'Pause';
          break;
      }
    });
  }
}
