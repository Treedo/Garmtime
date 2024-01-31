import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/personal_data.dart';
import 'screens/today.dart';
import 'screens/info.dart';
import 'providers/my_day.dart';
import 'providers/my_month.dart';
import 'providers/my_year.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) {
        MyYearProvider();
        MyMonthProvider();
        MyDayProvider();
      },
      child: const MainApp(),
    ), 
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (context) => MyDayProvider()),
    ChangeNotifierProvider(create: (context) => MyMonthProvider()),
    ChangeNotifierProvider(create: (context) => MyYearProvider()),
  ],
  child: MaterialApp(
      theme: ThemeData(
        primaryColor: const Color.fromARGB(179, 255, 204, 0),
      ),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.orange,
            title: const Text('Inner Light Guide'),
          ),
          body: const TabBarView(
            children: <Widget>[
              PersonalData(),
              Today(),
              Info(),
            ],
          ),
          bottomNavigationBar: const TabBar(
            //unselectedLabelColor: Colors.lightBlue,
            //labelColor: Colors.lightBlueAccent,
            tabs: [
              Tab(icon: Icon(Icons.person)),
              Tab(icon: Icon(Icons.calendar_today)),
              Tab(icon: Icon(Icons.info)),
            ],
          ),
        ),
      ),
    ));
  }
}
