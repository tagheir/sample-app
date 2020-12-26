import 'dart:async';
import 'package:bluebellapp/bloc/app_screen_bloc/app_screen_event.dart';
import 'package:bluebellapp/resources/constants/helper_constants/layout_constants.dart';
import 'package:bluebellapp/resources/constants/helper_constants/text_constants.dart';
import 'package:bluebellapp/resources/themes/light_color.dart';
import 'package:bluebellapp/resources/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:bluebellapp/resources/constants/helper_constants/extensions.dart';
import 'package:percent_indicator/percent_indicator.dart';

class TaskProgressScreen extends StatefulWidget {
  final List<Function> tasks;
  final bool showLoading;
  TaskProgressScreen({this.tasks, this.showLoading = false});
  @override
  _TaskProgressScreenState createState() => _TaskProgressScreenState();
}

class _TaskProgressScreenState extends State<TaskProgressScreen> {
  double tasksProgress = 0.0;
  double tasksProgressPercentage = 0.0;
  int tasksLength;
  bool dataInitialized = false;
  int count = 1;
  List<Widget> widgetList;

  initialize() async {
    //print("====task progress screen==========");
    AppTheme.deviceWidth = AppTheme.fullWidth(context);
    AppTheme.deviceHeight = AppTheme.fullHeight(context);
    widgetList = List<Widget>();
    if (!dataInitialized) {
      widgetList.add(getProgressMessage());
      tasksLength = widget.tasks.length;
      await Future.delayed(Duration(seconds: 1), () {
        runTasks();
        dataInitialized = true;
      });
    }
  }

  updateTaskProgress() {
    if (mounted) {
      setState(() {
        tasksProgress = ((100 / tasksLength) * count) / 100;
        tasksProgressPercentage = tasksProgress * 100;
        count++;
        print(
            "task length => $tasksLength ,  task progress =>  $tasksProgress, tasksProgressPercentage => $tasksProgressPercentage");
      });
    }
  }

  updateProgressValue(double value) {
    // if (mounted) {
    setState(() {
      tasksProgressPercentage = value;
    });
    //}
  }

  runTasks() async {
    for (Function func in widget.tasks) {
      //     await Future.delayed(Duration(seconds: 1), () {
      await func();
      updateTaskProgress();
      // });
    }
    context.getAppScreenBloc().add(AppScreenLoadingEvent());
  }

  @override
  Widget build(BuildContext context) {
    print("====task progress screen =====");
    initialize();
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.primaryColor,
      body: Stack(
        children: [
          Image.asset(
            'assets/images/logo.png',
            width: double.infinity,
          ).center(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: getProgressIndicator(),
                    ),
                  ],
                ),
                LayoutConstants.sizedBox15H,
                getProgressMessage()
              ],
            ),
          ),
        ],
      ).padding(EdgeInsets.only(left: 60, right: 60, bottom: 40)),
    );
  }

  Text getProgressMessage() {
    return Text('Initializing data...',
        textAlign: TextAlign.center,
        style: TextConstants.P6.apply(color: LightColor.white));
  }

  getProgressIndicator() {
    return LinearPercentIndicator(
      lineHeight: 28.0,
      percent: tasksProgress,
      center: Text(
        tasksProgressPercentage.toInt().toString() + " %",
        style: TextConstants.H8.apply(color: LightColor.white),
      ),
      animation: true,
      animateFromLastPercent: true,
      animationDuration: 1000,
      //restartAnimation: true,
      // trailing: Icon(Icons.mood),
      linearStrokeCap: LinearStrokeCap.roundAll,
      backgroundColor: Colors.grey,
      progressColor: LightColor.navy,
      // onAnimationValueChange: (value) {
      //   updateProgressValue(value);
      // },
    );
  }
}
