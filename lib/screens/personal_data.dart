import 'package:flutter/material.dart';
import '../settings.dart';

class PersonalData extends StatefulWidget {
  const PersonalData({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PersonalDataState createState() => _PersonalDataState();
}

class _PersonalDataState extends State<PersonalData> {
  DateTime _dateOfBirth = DateTime.now();
  final _preferencesService = PreferencesService();

  @override
  void initState() {
    super.initState();
    _loadDateOfBirth();
  }

  _loadDateOfBirth() async {
    _dateOfBirth = (await _preferencesService.loadDate())!;
    setState(() {});
  }

  _saveDateOfBirth(DateTime dob) async {
    await _preferencesService.saveDate(dob);
    setState(() {
      _dateOfBirth = dob;
    });
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
      color: const Color.fromRGBO(255, 255, 250, 185/255),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Date of Birth: ${_dateOfBirth.toIso8601String()}',
            ),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: const Text('Select date'),
            ),
          ],
        ),
      ),
    );
  }
}