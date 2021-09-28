import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String _email = '';
  String _uid = '';

  set email(String email) {
    _email = email;
    notifyListeners();
  }

  String get email {
    return _email;
  }

  set uid(String uid) {
    _uid = uid;
    notifyListeners();
  }

  String get uid {
    return _uid;
  }
}
