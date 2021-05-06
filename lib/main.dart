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
  CountDownController _breakController = CountDownController();
  int pomodoroCount = 0;
  int breakCount = 0;
  int pomodoroDuration = 1500; //1500 for 25 minutes
  int breakDuration = 300; //300 for 5 minutes
  bool _isRunning = false;
  bool _isBreak = false;
  String buttonText = 'Start';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '🍅 count: $pomodoroCount',
          style: TextStyle(fontSize: 24, color: Colors.amber),
        ),
        SizedBox(
          height: 50,
        ),
        Visibility(
          visible: _isBreak,
          child: CircularCountDownTimer(
            width: 300,
            height: 300,
            duration: breakDuration,
            isReverse: true,
            autoStart: false,
            textFormat: CountdownTextFormat.MM_SS,
            isTimerTextShown: _isRunning,
            controller: _breakController,
            fillColor: Color(0xFF0390FC),
            ringColor: Color(0xFF333333),
            onStart: () => _isRunning = true,
            onComplete: () => completeCountDown(),
          ),
        ),
        Visibility(
          visible: !_isBreak,
          child: CircularCountDownTimer(
            width: 300,
            height: 300,
            duration: pomodoroDuration,
            isReverse: true,
            autoStart: false,
            textFormat: CountdownTextFormat.MM_SS,
            controller: _countDownController,
            isTimerTextShown: _isRunning,
            fillColor: Color(0xFFE63E3E),
            ringColor: Color(0xFF333333),
            onStart: () => _isRunning = true,
            onComplete: () => completeCountDown(),
          ),
        ),
        SizedBox(
          height: 50,
        ),
        ElevatedButton(
          onPressed: () => {
            startCountDown(_isBreak ? _breakController : _countDownController)
          },
          child: Text(buttonText),
        ),
      ],
    );
  }

  void completeCountDown() {
    setState(() {
      _isRunning = false;
      buttonText = 'Start';
      if (_isBreak) {
        _isBreak = false;
        breakCount++;
      } else {
        _isBreak = true;
        pomodoroCount++;
      }
      if (breakCount > 0 && pomodoroCount % 4 == 0) {
        breakDuration = 1800;
      } else {
        breakDuration = 300;
      }
    });
  }

  void startCountDown(CountDownController _controller) {
    setState(() {
      switch (buttonText) {
        case 'Start':
          _controller.start();
          buttonText = 'Pause';
          _isRunning = true;
          break;
        case 'Pause':
          _controller.pause();
          buttonText = 'Resume';
          _isRunning = false;
          break;
        case 'Resume':
          _controller.resume();
          buttonText = 'Pause';
          _isRunning = true;
          break;
      }
    });
  }
}
