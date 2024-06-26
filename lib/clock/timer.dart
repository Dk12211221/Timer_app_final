import 'package:flutter/material.dart';
import "package:flutter_screenutil/flutter_screenutil.dart";
import 'dart:async';

import 'package:google_fonts/google_fonts.dart';

class ReverseTimerWidget extends StatefulWidget {
  const ReverseTimerWidget({super.key});

  @override
  _ReverseTimerWidgetState createState() => _ReverseTimerWidgetState();
}

class _ReverseTimerWidgetState extends State<ReverseTimerWidget> {
  late ReverseTimer _reverseTimer;
  int _remainingTime = 0;
  final TextEditingController _hoursController = TextEditingController();
  final TextEditingController _minutesController = TextEditingController();
  final TextEditingController _secondsController = TextEditingController();
  bool _isTimerRunning = false;

  @override
  void initState() {
    super.initState();
    _reverseTimer = ReverseTimer(
      durationInSeconds: 0, // Initial duration set to 0
      onTick: (remainingTime) {
        setState(() {
          _remainingTime = remainingTime;
        });
      },
      onTimerFinished: () {
        setState(() {
          _remainingTime = 0;
          _isTimerRunning = false;
          // Handle timer finished event here
        });
      },
    );
  }

  @override
  void dispose() {
    _reverseTimer.stopTimer();
    super.dispose();
  }

  void _startTimer() {
    int hours = int.tryParse(_hoursController.text) ?? 0;
    int minutes = int.tryParse(_minutesController.text) ?? 0;
    int seconds = int.tryParse(_secondsController.text) ?? 0;
    int totalSeconds = (hours * 3600) + (minutes * 60) + seconds;

    if (totalSeconds > 0) {
      _reverseTimer.durationInSeconds = totalSeconds;
      _reverseTimer.startTimer();
      _isTimerRunning = true;
    }
  }

  void _stopTimer() {
    _reverseTimer.stopTimer();
    _isTimerRunning = false;
  }

  void _resetTimer() {
    _hoursController.clear();
    _minutesController.clear();
    _secondsController.clear();
    _reverseTimer.stopTimer();
    setState(() {
      _remainingTime = 0;
      _isTimerRunning = false;
    });
  }

  String _formatTime(int time) {
    int hours = time ~/ 3600;
    int minutes = (time % 3600) ~/ 60;
    int seconds = time % 60;
    return '$hours:$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    String formattedTime = _formatTime(_remainingTime);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage('assets/bg_image.jpg'))),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                formattedTime,
                style: GoogleFonts.kanit(
                    textStyle:  TextStyle(
                      fontSize: 60.sp,
                      color: Colors.black,
                    )),
              ),
              SizedBox(height: 80.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 80,
                    child: TextField(
                      style: const TextStyle(
                          color: Colors.orange
                      ),
                      controller: _hoursController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelStyle: GoogleFonts.abel(),
                        labelText: 'Hours',
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                          const BorderSide(color: Colors.orange, width: 3),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                          const BorderSide(color: Colors.orange, width: 3),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 80,
                    child: TextField(
                      style: const TextStyle(
                          color: Colors.orange
                      ),
                      controller: _minutesController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        fillColor: Colors.orange,
                        labelStyle: GoogleFonts.abel(textStyle: const TextStyle(
                        )),
                        labelText: 'Minutes',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                          const BorderSide(color: Colors.orange, width: 3),
                        ),
                        focusedBorder: OutlineInputBorder(

                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                          const BorderSide(color: Colors.orange, width: 3),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 80,
                    child: TextField(
                      style: const TextStyle(
                          color: Colors.orange
                      ),
                      controller: _secondsController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelStyle: GoogleFonts.abel(),
                        labelText: 'Seconds',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                          const BorderSide(color: Colors.orange, width: 3),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                          const BorderSide(color: Colors.orange, width: 3),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 70),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      fixedSize: MaterialStatePropertyAll(Size(110.sp,65.sp)),
                      foregroundColor:
                      const MaterialStatePropertyAll(Colors.white),
                      backgroundColor:
                      MaterialStatePropertyAll(Colors.orange.shade300),
                    ),
                    onPressed: _isTimerRunning ? null : _startTimer,
                    child:  Text('Start\nTimer',style: GoogleFonts.abel(textStyle: TextStyle(fontSize: 20.sp)),),
                  ),
                  SizedBox(height: 10.sp),
                  ElevatedButton(
                    style: ButtonStyle(
                      fixedSize: MaterialStatePropertyAll(Size(110.sp,65.sp)),
                      foregroundColor:
                      const MaterialStatePropertyAll(Colors.white),
                      backgroundColor:
                      MaterialStatePropertyAll(Colors.orange.shade300),
                    ),
                    onPressed: _isTimerRunning ? _stopTimer : null,
                    child:  Text('Stop\nTimer',style: GoogleFonts.abel(textStyle: TextStyle(fontSize: 20.sp)),),
                  ),
                  SizedBox(height: 10.sp),
                  ElevatedButton(
                    style: ButtonStyle(
                      fixedSize: MaterialStatePropertyAll(Size(110.sp,65.sp)),
                      foregroundColor:
                      const MaterialStatePropertyAll(Colors.white),
                      backgroundColor:
                      MaterialStatePropertyAll(Colors.orange.shade300),
                    ),
                    onPressed: _resetTimer,
                    child: Text('Reset\nTimer',style: GoogleFonts.abel(textStyle: TextStyle(fontSize: 20.sp)),),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReverseTimer {
  late Timer _timer;
  late int durationInSeconds;
  late Function(int) onTick;
  late Function() onTimerFinished;

  ReverseTimer({
    required this.durationInSeconds,
    required this.onTick,
    required this.onTimerFinished,
  });

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (durationInSeconds > 0) {
        durationInSeconds--;
        onTick(durationInSeconds);
      } else {
        _timer.cancel();
        onTimerFinished();
      }
    });
  }

  void stopTimer() {
    _timer.cancel();
  }
}