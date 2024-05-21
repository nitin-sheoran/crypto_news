import 'package:news_wave/all_imports.dart';

class ThemeProvider with ChangeNotifier {
  bool _darkMode = false;

  ThemeProvider() {
    _loadDarkMode();
  }

  bool get darkMode => _darkMode;

  set darkMode(bool value) {
    _darkMode = value;
    DarkModePreference.setDarkMode(value);
    notifyListeners();
  }

  Future<void> _loadDarkMode() async {
    _darkMode = await DarkModePreference.getDarkMode();
    notifyListeners();
  }
}
