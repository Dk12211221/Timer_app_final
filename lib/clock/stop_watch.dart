import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class StopWatch extends StatefulWidget {
  const StopWatch({super.key});

  @override
  StopWatchState createState() => StopWatchState();
}

class StopWatchState extends State<StopWatch> {
  late Timer _timer;
  int _hours = 0;
  int _minutes = 0;
  int _seconds = 0;
  List hours = [];
  List minutes = [];
  List second = [];
  @override
  void initState() {
    super.initState();
  }

  void startTimer() {
    const oneSecond = Duration(seconds: 1);
    _timer = Timer.periodic(oneSecond, (timer) {
      setState(() {
        _seconds++;
        if (_seconds == 60) {
          _seconds = 0;
          _minutes++;
          if (_minutes == 60) {
            _minutes = 0;
            _hours++;
          }
        }
      });
    });
  }

  void flag(){
    setState(() {
      hours.add(_hours);
      minutes.add(_minutes);
      second.add(_seconds);
    });
  }

  void restart(){
    setState(() {
      _hours = 0;
      _minutes = 0;
      _seconds = 0;


    });
    second.clear();
    hours.clear();
    minutes.clear();
    _timer.cancel();
  }

  void stop(){
    _timer.cancel();
  }
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      // appBar: AppBar(
      //
      //   backgroundColor: Colors.blue,
      //   centerTitle: true,
      //   title: const Text('Stop Watch',style: TextStyle(fontSize: 35,color: Colors.white),),
      // ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage('assets/bg_image.jpg'))),

        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 90,),
              Column(
                children: [
                  Text(
                    '$_hours : $_minutes : $_seconds',
                    style: GoogleFonts.kanit(textStyle:const TextStyle(fontSize: 60,),),
                    // style: const TextStyle(fontSize: 60,fontFamily: 'Jersey10'),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      OutlinedButton(
                          style: ButtonStyle(
                            fixedSize: MaterialStatePropertyAll(Size(110.sp,24.sp)),
                            foregroundColor:
                            const MaterialStatePropertyAll(Colors.white),
                            backgroundColor:
                            MaterialStatePropertyAll(Colors.orange.shade300),
                          ),
                          onPressed: startTimer,
                          child: Text('Start',style: GoogleFonts.abel(textStyle: TextStyle(fontSize: 25.sp)),)
                      ),
                      OutlinedButton(
                          style: ButtonStyle(
                            fixedSize: MaterialStatePropertyAll(Size(110.sp,24.sp)),
                            foregroundColor:
                            const MaterialStatePropertyAll(Colors.white),
                            backgroundColor:
                            MaterialStatePropertyAll(Colors.orange.shade300),
                          ),
                          onPressed: restart,
                          child: Text('Reset',style: GoogleFonts.abel(textStyle: TextStyle(fontSize: 25.sp)),)
                      ),


                    ],
                  ),
                  SizedBox(height: 15.h,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      OutlinedButton(
                          style: ButtonStyle(
                            fixedSize: MaterialStatePropertyAll(Size(110.sp,24.sp)),
                            foregroundColor:
                            const MaterialStatePropertyAll(Colors.white),
                            backgroundColor:
                            MaterialStatePropertyAll(Colors.orange.shade300),
                          ),
                          onPressed: flag,
                          child: Text('Flag',style: GoogleFonts.abel(textStyle: TextStyle(fontSize: 25.sp)))
                      ),
                      OutlinedButton(
                          style: ButtonStyle(
                            fixedSize: MaterialStatePropertyAll(Size(110.sp,24.sp)),
                            foregroundColor:
                            const MaterialStatePropertyAll(Colors.white),
                            backgroundColor:
                            MaterialStatePropertyAll(Colors.orange.shade300),
                          ),
                          onPressed: stop,
                          child: Text('Stop',style: GoogleFonts.abel(textStyle: TextStyle(fontSize: 25.sp)))
                      ),
                    ],
                  )
                ],
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: second.length,
                    itemBuilder: (context, index){
                      return
                        Card(
                          color: index%2==0? Colors.grey[400]:Colors.white54,
                          child: ListTile(
                              title: Text('${hours[index]} : ${minutes[index]} : ${second[index]}',style: const TextStyle(fontSize: 30),)),
                        );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}