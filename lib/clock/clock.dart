import 'package:analog_clock/analog_clock.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Clock extends StatefulWidget {
  const Clock({super.key});

  @override
  State<Clock> createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  late DateTime dateTime;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    digitalClock();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 10,
      //   title: Text(
      //     'Clock',
      //     style: GoogleFonts.aBeeZee(
      //         textStyle: const TextStyle(fontSize: 35, color: Colors.black)),
      //   ),
      //   centerTitle: true,
      //   // backgroundColor: Colors.blue,
      // ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/bg_image.jpg')
            )
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 70,
              ),
              SizedBox(
                height: 350,
                width: 350,
                child: AnalogClock(
                  decoration: BoxDecoration(
                      image: const DecorationImage(
                          image: AssetImage('assets/Analog_clock_skin.jpeg')

                      ),
                      border: Border.all(width: 4.0, color: Colors.black),
                      color: Colors.grey.shade200,
                      shape: BoxShape.circle), // decoration
                  width: 200.0,
                  isLive: true,
                  hourHandColor: Colors.grey,
                  minuteHandColor: Colors.orange,
                  showSecondHand: true,
                  showNumbers: false,
                  textScaleFactor: 1.5,
                  showTicks: true,
                  tickColor: Colors.transparent,
                  secondHandColor: Colors.orangeAccent,
                  showDigitalClock: false,
                  datetime: DateTime.now(),
                ),
              ),
              const Spacer(),
              Column(
                children: [
                  Text('India',style: GoogleFonts.kanit(textStyle:const TextStyle(fontSize: 35,color: Colors.grey))),
                  Text(
                    DateFormat('hh:mm:ss a').format(dateTime),
                    style: GoogleFonts.kanit(textStyle:const TextStyle(fontSize: 59,color: Colors.orange)),
                  ),
                  Text(
                    DateFormat('E,MMM d').format(dateTime),
                    style: GoogleFonts.kanit(textStyle:const TextStyle(fontSize: 35,color: Colors.grey)),
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> digitalClock() async {
    dateTime = DateTime.now();
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        dateTime = DateTime.now();
      });
      digitalClock();
    });
  }
}