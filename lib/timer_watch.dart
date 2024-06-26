import 'package:flutter/material.dart';
import 'dart:async';

class TimerWatch extends StatefulWidget {
  @override
  _TimerWatchState createState() => _TimerWatchState();
}

class _TimerWatchState extends State<TimerWatch> {
  Timer? _timer;
  int _remainingSeconds = 0;
  bool _isCountingDown = true;
  final List<String> _laps = [];
  final TextEditingController _minutesController = TextEditingController();
  final TextEditingController _secondsController = TextEditingController();

  void startTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
    setState(() {
      int minutes = int.tryParse(_minutesController.text) ?? 0;
      int seconds = int.tryParse(_secondsController.text) ?? 0;
      _remainingSeconds = minutes * 60 + seconds;
    });
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (_isCountingDown) {
          if (_remainingSeconds > 0) {
            _remainingSeconds--;
          } else {
            timer.cancel();
          }
        } else {
          _remainingSeconds++;
        }
      });
    });
  }

  void stopTimer() {
    _timer?.cancel();
  }

  void resetTimer() {
    _timer?.cancel();
    setState(() {
      _remainingSeconds = 0;
      _laps.clear();
    });
    _minutesController.clear();
    _secondsController.clear();
  }

  void flagLap() {
    setState(() {
      _laps.add(_formatTime(_remainingSeconds));
    });
  }

  void reverseTimer() {
    setState(() {
      _isCountingDown = !_isCountingDown;
    });
  }

  String _formatTime(int totalSeconds) {
    final int minutes = totalSeconds ~/ 60;
    final int seconds = totalSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    _minutesController.dispose();
    _secondsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            _formatTime(_remainingSeconds),
            style: TextStyle(fontSize: 48),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 80,
                child: TextField(
                  controller: _minutesController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Minutes',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(width: 10),
              SizedBox(
                width: 80,
                child: TextField(
                  controller: _secondsController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Seconds',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: startTimer,
                child: Text('Start'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: stopTimer,
                child: Text('Stop'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: resetTimer,
                child: Text('Reset'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: reverseTimer,
                child: Text('Reverse'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: flagLap,
                child: Text('Lap'),
              ),
            ],
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: _laps.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Lap ${index + 1}: ${_laps[index]}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
