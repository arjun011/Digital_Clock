import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'dart:math' as math;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'digital_clock',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: DigitalClock(title: 'Digital Clock'),
    );
  }
}

class DigitalClock extends StatefulWidget {
  DigitalClock({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _DigitalClockState createState() => _DigitalClockState();
}

class _DigitalClockState extends State<DigitalClock> {
  DateTime _dateTime = DateTime.now();
  Color _minuteBackgroundColor;
  Color _hourBackgroundColor;
   
  @override
  void initState() {
    super.initState();
    _updateTime();
    _updateMinutueColor();
  }
  /// Update minute container background color
  void _updateMinutueColor() {
    setState(() {
      _minuteBackgroundColor = Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
    });
  }
  /// Update hour container background color
  void _updateHourColor() {
    setState(() {
      _hourBackgroundColor = Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
    });
  }
  /// Update time interval
  void _updateTime() {
    setState(() {
      _dateTime = DateTime.now();
      // Update once per minute. 
      // Timer(
      //   Duration(minutes: 1) -
      //       Duration(seconds: _dateTime.second) -
      //       Duration(milliseconds: _dateTime.millisecond),
      //   _updateTime,
      // );
      // Update once per second, but make sure to do it at the beginning of each
      // new second, so that the clock is accurate.
       Timer(
        Duration(seconds: 1) - Duration(milliseconds: _dateTime.millisecond),
        _updateTime,
      );
    });
  }

  @override
  Widget build(BuildContext context) {

    final hour =  DateFormat('HH').format(_dateTime);
    final minute = DateFormat('mm').format(_dateTime);
    final seconds = DateFormat('ss').format(_dateTime);
    print('second =$seconds');

    if (seconds == '00') {
      _updateMinutueColor();
    }
    if (minute == '00') {
      _updateHourColor();
    }

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Row(
        children: <Widget>[
                  AnimatedContainer(
                    color: _hourBackgroundColor,
                    padding: EdgeInsets.only(right: 10),
                    alignment: Alignment.centerRight,
                    width: MediaQuery.of(context).size.width / 2,  // Also Including Tab-bar height.
                    child: Text(hour,style: TextStyle(fontFamily: 'Digital',fontSize: 150)),
                    duration: Duration(seconds: 5),
                    curve: Curves.elasticOut
                  ),
                  AnimatedContainer(
                    color: _minuteBackgroundColor,
                    padding: EdgeInsets.only(left: 10),
                    alignment: Alignment.centerLeft,
                    width: MediaQuery.of(context).size.width / 2,  // Also Including Tab-bar height.
                    child: Text(minute,style: TextStyle(fontFamily: 'Digital',fontSize: 150)),
                    duration: Duration(seconds: 5),
                    curve: Curves.bounceOut
                  )
        ],
      )
    );

  }
}
