import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String? _email;
  String? _username;
  String? _photoUrl;

  String? get email => _email;
  String? get username => _username;
  String? get photoUrl => _photoUrl;

  bool get isLoggedIn => _email != null;

  // Update user info after login or registration
  void setUser({
    required String email,
    required String username,
    String? photoUrl,
  }) {
    _email = email;
    _username = username;
    _photoUrl = photoUrl;
    notifyListeners();
  }

  // Logout / clear user data
  void logout() {
    _email = null;
    _username = null;
    _photoUrl = null;
    notifyListeners();
  }
}
