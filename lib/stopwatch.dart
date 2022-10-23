import 'dart:async';
import 'package:flutter/material.dart';
import 'package:just_another_stopwatch/styles.dart';

class StopwatchPage extends StatefulWidget {
  const StopwatchPage({super.key});

  @override
  State<StopwatchPage> createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  Duration duration = const Duration(seconds: 1);
  Stopwatch stopwatch = Stopwatch();
  String hours = '00';
  String minutes = '00';
  String seconds = '00';
  String startStopLabel = 'START';

  void ticker() {
    Timer(duration, timeRunning);
  }

  void timeRunning() {
    if (stopwatch.isRunning) {
      ticker();
    }
    setState(() {
      hours = stopwatch.elapsed.inHours.toString().padLeft(2, '0');
      minutes = (stopwatch.elapsed.inMinutes % 60).toString().padLeft(2, '0');
      seconds = (stopwatch.elapsed.inSeconds % 60).toString().padLeft(2, '0');
    });
  }

  void timeStart() {
    stopwatch.start();
    ticker();

    setState(() {
      startStopLabel = 'STOP';
    });
  }

  void timeStop() {
    stopwatch.stop();

    setState(() {
      startStopLabel = 'START';
    });
  }

  void timeReset() {
    stopwatch.reset();

    setState(() {
      hours = '00';
      minutes = '00';
      seconds = '00';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 700,),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // TIME TICKER
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TimeCard(display: hours, unit: 'h',),
                    TimeCard(display: minutes, unit: 'm',),
                    TimeCard(display: seconds, unit: 's',),
                  ],
                ),
                // SPACING
                const SizedBox(
                  height: 72.0,
                ),
                // ACTION BUTTONS
                Row(
                  children: [
                    ActionButton(
                      label: 'RESET',
                      onPressed: timeReset,
                      foregroundColor: AppStyle.black,
                      backgroundColor: AppStyle.grey,
                    ),
                    ActionButton(
                      label: startStopLabel,
                      onPressed: stopwatch.isRunning ? timeStop : timeStart,
                      foregroundColor: AppStyle.grey,
                      backgroundColor: AppStyle.black,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TimeCard extends StatelessWidget {
  const TimeCard({
    Key? key,
    required this.display,
    required this.unit,
  }) : super(key: key);

  final String display;
  final String unit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            width: 32.0,
            child: Center(
              child: Text(
                display[0],
                style: AppStyle.timeCardText,
              ),
            ),
          ),
          SizedBox(
            width: 32.0,
            child: Center(
              child: Text(
                display[1],
                style: AppStyle.timeCardText,
              ),
            ),
          ),
          Text(
            unit,
            style: TextStyle(
              height: 2.5,
              fontSize: 20.0,
              color: AppStyle.black,
            ),
          ),
        ],
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.label,
    required this.onPressed,
    required this.foregroundColor,
    required this.backgroundColor,
  });

  final String label;
  final Function onPressed;
  final Color foregroundColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextButton(
          onPressed: () => onPressed(),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            foregroundColor: foregroundColor,
            backgroundColor: backgroundColor,
          ),
          child: Text(label.toUpperCase()),
        ),
      ),
    );
  }
}
