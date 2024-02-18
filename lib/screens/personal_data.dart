import 'package:flutter/material.dart';
import 'package:garmtime/main.dart';
import 'package:garmtime/models/numerologic_provider.dart';
import 'package:garmtime/models/preferences_service.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PersonalData extends StatefulWidget {
  const PersonalData({super.key});

  @override
  PersonalDataState createState() => PersonalDataState();
}

class PersonalDataState extends State<PersonalData> {
  DateTime? _dateOfBirth;
  final DateTime _currentDate = DateTime.now();
  final _preferencesService = PreferencesService();

  ValueNotifier<List<TextSpan>>? futureNotifier;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();

    futureNotifier =
        ValueNotifier<List<TextSpan>>([const TextSpan(text: 'Завантаження')]);
    _loadDateOfBirth();
  }

  _loadDateOfBirth() async {
    _dateOfBirth = (await _preferencesService.loadDate())!;
    loadTest1(_dateOfBirth!);

    setState(() {});
  }

  _saveDateOfBirth(DateTime dob) async {
    await _preferencesService.saveDate(dob);
    _dateOfBirth = dob;
    loadTest1(_dateOfBirth!);

    setState(() {});
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

  // Допоміжна функція для зведення числа до однозначного
  Map<String, dynamic> _reduceToOneDigit(String number) {
    String process = '';
    while (number.length > 1) {
      int sum = 0;
      for (int i = 0; i < number.length; i++) {
        sum += int.parse(number[i]);
        process += number[i];
        if (i < number.length - 1) {
          process += '+';
        }
      }
      number = sum.toString();
      process += ' = $number';
      if (number.length > 1) {
        process += ' => ';
      }
    }
    return {
      'result': int.parse(number),
      'process': process.trim() == '' ? number : process.trim()
    };
  }

  // Функція для генерації розрахункового звіту
  List<TextSpan> generateReport(DateTime thisDate, DateTime dateOfBirth) {
    String universalYearProcess = calculateUniversalYear(thisDate)['process'];
    Map<String, dynamic> personalYear =
        calculatePersonalYear(thisDate, dateOfBirth);
    String personalMonthProcess =
        calculatePersonalMonth(thisDate, dateOfBirth)['process'];
    Map<String, dynamic> personalDay =
        calculatePersonalDay(thisDate, dateOfBirth);

    Provider.of<MyNumerologigProvider>(context, listen: false)
        .setMyYear(personalYear['result']);
    Provider.of<MyNumerologigProvider>(context, listen: false)
        .setMyDay(personalDay['result']);

    List<TextSpan> listTextNumerology = [
      const TextSpan(
          text: 'Універсальний рік:\n', style: TextStyle(color: Colors.grey)),
      TextSpan(
          text: universalYearProcess,
          style: const TextStyle(color: Colors.grey, fontSize: 16)),
      const TextSpan(
          text: '\n\nМій рік:\n',
          style: TextStyle(color: Colors.indigo, fontSize: 16)),
      TextSpan(
          text: personalYear['process'],
          style: const TextStyle(color: Colors.indigo, fontSize: 18)),
      const TextSpan(
          text: '\n\nМій місяць:\n', style: TextStyle(color: Colors.grey)),
      TextSpan(
          text: personalMonthProcess,
          style: const TextStyle(color: Colors.grey, fontSize: 16)),
      const TextSpan(
          text: '\n\nМій день:\n',
          style: TextStyle(color: Colors.indigo, fontSize: 16)),
      TextSpan(
          text: personalDay['process'],
          style: const TextStyle(color: Colors.indigo, fontSize: 18)),
    ];

    return listTextNumerology;
  }

  // Функція, що розраховує універсальну дату
  Map<String, dynamic> calculateUniversalYear(DateTime thisDate) {
    String year = DateFormat('yyyy').format(thisDate);
    return _reduceToOneDigit(year);
  }

  // Функція для розрахунку персонального року
  Map<String, dynamic> calculatePersonalYear(
      DateTime thisDate, DateTime dateOfBirth) {
    var universalYearResult =
        _reduceToOneDigit(DateFormat('yyyy').format(thisDate));
    int birthMonth = int.parse(DateFormat('MM').format(dateOfBirth));
    int birthDay = int.parse(DateFormat('dd').format(dateOfBirth));
    return _reduceToOneDigit(
        '${universalYearResult['result']}$birthMonth$birthDay');
  }

  // Функція для розрахунку персонального місяця
  Map<String, dynamic> calculatePersonalMonth(
      DateTime thisDate, DateTime dateOfBirth) {
    var personalYearResult = _reduceToOneDigit(
        calculatePersonalYear(thisDate, dateOfBirth)['result'].toString());
    int currentMonth = int.parse(DateFormat('MM').format(thisDate));
    return _reduceToOneDigit('${personalYearResult['result']}$currentMonth');
  }

  // Функція для розрахунку персонального дня
  Map<String, dynamic> calculatePersonalDay(
      DateTime thisDate, DateTime dateOfBirth) {
    var personalMonthResult = _reduceToOneDigit(
        calculatePersonalMonth(thisDate, dateOfBirth)['result'].toString());
    int currentDay = int.parse(DateFormat('dd').format(thisDate));
    return _reduceToOneDigit('${personalMonthResult['result']}$currentDay');
  }

  void loadTest1(DateTime dateOfBirth) async {
    DateTime thisDate = DateTime.now();
    List<TextSpan> report = generateReport(thisDate, dateOfBirth);

    futureNotifier?.value = report;

    if (firstRun) {
      firstRun = false;
      await Future.delayed(const Duration(seconds: 1));
      // ignore: use_build_context_synchronously
      DefaultTabController.of(context).animateTo(1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
    builder: (BuildContext context, BoxConstraints viewportConstraints) {
      return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: viewportConstraints.maxHeight,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              Text(
                'Сьогодні: \n${DateFormat('dd MMMM yyyy', 'uk').format(_currentDate)}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: 
                    Theme.of(context).colorScheme.secondary,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Ваша дата народження: \n${_dateOfBirth != null ? DateFormat('dd MMMM yyyy', 'uk').format(_dateOfBirth!) : 'Не вказана'}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.error,
                  
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                ),
                onPressed: () {
                  _selectDate(context);
                },
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Вказати дату народження',
                    style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.primary,),
                  ),
                ),
              ),              
              const SizedBox(height: 30),
              ValueListenableBuilder<List<TextSpan>>(
                valueListenable: futureNotifier!,
                builder:
                    (BuildContext context, List<TextSpan> value, Widget? child) {
                  return value.isNotEmpty
                      ? RichText(
                          text: TextSpan(
                            children: value,
                          ),
                        )
                      : const CircularProgressIndicator();
                },
              ),
            ],
          ),
        ),
      ),
    );
  });
  }
}