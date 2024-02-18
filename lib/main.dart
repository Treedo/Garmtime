import 'package:flutter/material.dart';
import 'package:garmtime/models/numerologic_provider.dart';
import 'package:garmtime/screens/info.dart';
import 'package:provider/provider.dart';
import 'package:garmtime/screens/personal_data.dart';
import 'package:garmtime/screens/today.dart';

bool firstRun = true;

const Color mainColor =  Color.fromARGB(255, 255, 170, 0);


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
          theme: ThemeData.light().copyWith(
            scaffoldBackgroundColor: const Color.fromARGB(255, 248, 245, 255),
            colorScheme: const ColorScheme(
              brightness: Brightness.light,
              primary: Color.fromARGB(255, 255, 235, 204),
              onPrimary: Colors.black,
              secondary: Colors.indigo,
              onSecondary: Colors.black,
              error: Color.fromARGB(255, 95, 93, 186),
              onError: Colors.black,
              onBackground: Colors.black,
              background: Colors.black,
              surface: Colors.indigo,
              onSurface: Colors.black,
            ),
          ),
          darkTheme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: const Color.fromARGB(255, 32, 30, 40),
            colorScheme: const ColorScheme(
              brightness: Brightness.light,
              primary: Color.fromARGB(255, 255, 235, 204),
              onPrimary: Colors.white,
              secondary: Color.fromARGB(255, 255, 235, 204),
              onSecondary: Colors.black,
              error: Color.fromARGB(255, 161, 156, 171),
              onError: Colors.black,
              onBackground: Colors.black,
              background: Colors.white,
              surface: Color.fromARGB(255, 92, 80, 177),
              onSurface: Colors.black,
            ),
          ),
          themeMode: ThemeMode.system, // Default mode

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
