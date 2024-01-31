import 'package:flutter/material.dart';
import 'package:inner_light_guide/providers/my_day.dart';
import 'package:inner_light_guide/providers/my_month.dart';
import 'package:inner_light_guide/providers/my_year.dart';
import 'package:provider/provider.dart';

// ignore: use_key_in_widget_constructors
class Today extends StatefulWidget {
  const Today({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TodayState createState() => _TodayState();
}

class _TodayState extends State<Today> {
  @override
  Widget build(BuildContext context) {
    int myDay = Provider.of<MyDayProvider>(context).myDay;
    int myMonth = Provider.of<MyMonthProvider>(context).myMonth;
    int myYear = Provider.of<MyYearProvider>(context).myYear;

    return Center(
      child: 
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Today is your day: '),
          Text(myDay.toString()),
          const SizedBox(width: 10),
          const Text('My month: '),
          Text(myMonth.toString()),
          const SizedBox(width: 10),
          const Text('My year: '),
          Text(myYear.toString()),
        ],
      ),
    );
  }
}