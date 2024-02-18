import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  Future<DateTime?> loadDate() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? dateString = prefs.getString('dateOfBirth');
    if (dateString != null) {
      return DateTime.parse(dateString);
    }
    return null;
  }

  Future<void> saveDate(DateTime date) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('dateOfBirth', date.toIso8601String());
  }
}