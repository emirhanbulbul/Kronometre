import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeApp extends StatefulWidget {
  const HomeApp({Key? key}) : super(key: key);

  @override
  _HomeAppState createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  int second = 0;
  int minute = 0;
  int hours = 0;
  String _Second = "00";
  String _Minutes = "00";
  String _Hours = "00";
  Timer? timer;
  bool started = false;
  List list = [];

  void stop() {
    timer!.cancel();
    setState(() {
      started = false;
    });
  }

  void reset() {
    timer!.cancel();
    setState(() {
      second = 0;
      minute = 0;
      hours = 0;
      _Hours = "00";
      _Minutes = "00";
      _Second = "00";
      started = false;
    });
  }

  void addList() {
    String temp = "$_Hours:$_Minutes:$_Second";
    setState(() {
      list.add(temp);
    });
  }

  void start() {
    started = true;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      int localsecond = second + 1;
      int localminute = minute;
      int localhour = hours;

      if (localsecond > 59) {
        if (localminute > 59) {
          localhour++;
          localminute = 0;
        } else {
          localminute++;
          localsecond = 0;
        }
      }
      setState(() {
        second = localsecond;
        minute = localminute;
        hours = localhour;
        _Second = (second >= 10) ? "$second" : "0$second";
        _Minutes = (minute >= 10) ? "$minute" : "0$minute";
        _Hours = (hours >= 10) ? "$hours" : "0$hours";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF1C2757),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Center(
                      child: Text("Kronometre",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold))),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      "$_Hours:$_Minutes:$_Second",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 80,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    height: 400,
                    decoration: BoxDecoration(
                        color: Color(0xFF323F68),
                        borderRadius: BorderRadius.circular(8)),
                    child: ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${index + 1}. Tur",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              Text(
                                "${list[index]}",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: RawMaterialButton(
                        onPressed: () {
                          if (started == false) {
                            start();
                          } else {
                            stop();
                          }
                          setState(() {});
                        },
                        shape: const StadiumBorder(
                            side: BorderSide(color: Colors.blue)),
                        child: Text(
                          (!started) ? "Başla" : "Durdur",
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                      IconButton(
                          color: Colors.white,
                          onPressed: () {
                            addList();
                          },
                          icon: Icon(Icons.flag)),
                      Expanded(
                          child: RawMaterialButton(
                        onPressed: () {
                          reset();
                        },
                        fillColor: Colors.blue,
                        shape: const StadiumBorder(
                            side: BorderSide(color: Colors.blue)),
                        child: Text(
                          "Sıfırla",
                          style: TextStyle(color: Colors.white),
                        ),
                      ))
                    ],
                  ),
                ]),
          ),
        ));
  }
}
