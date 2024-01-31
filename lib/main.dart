import 'package:flutter/material.dart';
import 'screens/personal_data.dart';
import 'screens/today.dart';
import 'screens/info.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
            children: [
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
    );
  }
}
