import 'package:flutter/material.dart';

class SearchboxProvider extends ChangeNotifier {
  bool _searchBoxOpacity = false;
  bool get searchBoxOpacity => _searchBoxOpacity;

  bool _seachBoxIsEnabled = false;

  bool _uiVisibility = true;
  bool get uiVisibility => _uiVisibility;

  toggleSearchBoxVisiblity() {
    _seachBoxIsEnabled = true;

    _searchBoxOpacity = _seachBoxIsEnabled ? true : false;

    notifyListeners();
  }

  toggleUivisibility() {
    _uiVisibility = false;
  }

  weatherFetched() {
    _searchBoxOpacity = false;
    _uiVisibility = true;
    notifyListeners();
  }
}
