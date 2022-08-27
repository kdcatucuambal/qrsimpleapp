import 'package:flutter/widgets.dart';

class UiProvider extends ChangeNotifier {
  int _selectedMenuOpt = 0;

  // ignore: unnecessary_getters_setters
  int get selectedMenuOpt => _selectedMenuOpt;

  set selectedMenuOpt(int value) {
    _selectedMenuOpt = value;
    notifyListeners();
  }
}
