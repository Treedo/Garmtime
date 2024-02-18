import 'package:flutter/material.dart';
import 'package:garmtime/models/numerologic_provider.dart';
import 'package:garmtime/screens/info.dart';
import 'package:provider/provider.dart';
import 'package:garmtime/screens/personal_data.dart';
import 'package:garmtime/screens/today.dart';



bool firstRun = true;

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => MyNumerologigProvider(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => MyNumerologigProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: const Color.fromARGB(179, 255, 204, 0),
          ),
          home: const DefaultTabController(
            length: 3,
            child: Scaffold(
              body: SafeArea(
                child: TabBarView(
                  children: <Widget>[
                    PersonalData(),
                    Today(),
                    Info(),
                  ],
                ),
              ),
              bottomNavigationBar: TabBar(
                dividerHeight: 48,
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










