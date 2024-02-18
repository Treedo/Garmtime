import 'package:flutter/material.dart';
import 'package:garmtime/data.dart';
import 'package:garmtime/models/numerologic_provider.dart';
import 'package:garmtime/widgets/expansion_tile_item_widget.dart';
import 'package:provider/provider.dart';

class Today extends StatefulWidget {
  const Today({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TodayState createState() => _TodayState();
}

class _TodayState extends State<Today> {
  //List<Item> data = [];

  @override
  Widget build(BuildContext context) {
    int dayIndex = Provider.of<MyNumerologigProvider>(context).myDay;
    int yearIndex = Provider.of<MyNumerologigProvider>(context).myYear;

    String myDay = dayIndex.toString();
    String myYear = yearIndex.toString();

    String myDayText = data['days']![dayIndex - 1];
    String myYearText = data['years']![yearIndex - 1];

    return ExpansionPanelListExample(
      myDayText: myDayText,
      myYearText: myYearText,
      myDay: myDay,
      myYear: myYear,
    );
  }
}