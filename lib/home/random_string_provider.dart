import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RandomStringProvider with ChangeNotifier {
  String _randomString = "Quick Button"; // Default text
  String? _errorMessage; // To store error message
  bool _isLoading = false; // To track loading state

  String get randomString => _randomString;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  Future<void> fetchRandomString() async {
    _isLoading = true;
    _errorMessage = null; // Clear any previous error
    notifyListeners();

    try {
      final response = await http.get(Uri.parse(
        'https://o7q6ka26qs232rmbtpbrxghy6u0vyrup.lambda-url.ap-southeast-1.on.aws/',
      ));

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        _randomString = jsonResponse['randomString'];
      } else {
        _errorMessage = 'Failed to load random string';
        print(_errorMessage);
      }
    } catch (e) {
      _errorMessage = 'An error occurred: $e';
      print(_errorMessage);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
