import 'package:flutter/material.dart';
import 'package:inner_light_guide/providers/my_day.dart';
import 'package:inner_light_guide/providers/my_month.dart';
import 'package:inner_light_guide/providers/my_year.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../settings.dart';

class PersonalData extends StatefulWidget {
  const PersonalData({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PersonalDataState createState() => _PersonalDataState();
}

class _PersonalDataState extends State<PersonalData> {
  DateTime? _dateOfBirth;
  final DateTime _currentDate = DateTime.now();
  final _preferencesService = PreferencesService();

  @override
  void initState() {
    super.initState();
    _loadDateOfBirth();

    
  }

  _loadDateOfBirth() async {
    _dateOfBirth = (await _preferencesService.loadDate())!;
    _calculateMyDay(_dateOfBirth);

    setState(() {});
  }

  _saveDateOfBirth(DateTime dob) async {
    await _preferencesService.saveDate(dob);
    setState(() {
      _dateOfBirth = dob;
      // func calculate my day from date of birth
      _calculateMyDay(_dateOfBirth);

    });
  }

  _calculateMyDay (dateOfBirth) {
    Provider.of<MyDayProvider>(context, listen: false).setMyDay(dateOfBirth.day);
    Provider.of<MyMonthProvider>(context, listen: false).setMyMonth(dateOfBirth.month);
    Provider.of<MyYearProvider>(context, listen: false).setMyYear(dateOfBirth.year);
  }


  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dateOfBirth,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _dateOfBirth) {
      _saveDateOfBirth(picked);
    }
  }

@override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: const Color.fromRGBO(255, 255, 250, 1),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Current date: \n${DateFormat('dd MMMM yyyy').format(_currentDate)}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.blueGrey,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Date of Birth: \n${_dateOfBirth != null ? DateFormat('dd MMMM yyyy').format(_dateOfBirth!) : 'Not set'}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange, 
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              onPressed: () => _selectDate(context),
              child: const Text('Select date', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
