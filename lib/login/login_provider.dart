import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  // login credentials
  final Map<String, String> _credentials = {
    'rjsanjuan@gmail.com': 'password123',
    'inventi@gmail.com': 'pass456',
  };

  bool _isAuthenticated = false;
  String? _errorMessage;

  bool get isAuthenticated => _isAuthenticated;
  String? get errorMessage => _errorMessage;

  void login(String email, String password) {
    _errorMessage = null;

    if (_credentials.containsKey(email)) {
      if (_credentials[email] == password) {
        _isAuthenticated = true;
      } else {
        _errorMessage = 'Incorrect password';
        print(_errorMessage);
        _isAuthenticated = false;
      }
    } else {
      _errorMessage = 'Email not found';
      print(_errorMessage);
      _isAuthenticated = false;
    }

    notifyListeners();
  }

  void logout() {
    _isAuthenticated = false;
    _errorMessage = null;
    notifyListeners();
  }
}
