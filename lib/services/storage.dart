import 'package:shared_preferences/shared_preferences.dart';

Future<bool> checkUser() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String? storedUser = pref.getString('user');
  return storedUser != null;
}
