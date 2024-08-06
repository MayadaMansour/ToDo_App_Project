import 'package:flutter/material.dart';
import 'package:todo_app_project/core/model/user_model.dart';

class AuthUserProvider extends ChangeNotifier {
  MyUser? currentUser;

  void updateUser(MyUser newUser) {
    currentUser = newUser;
    notifyListeners();
  }
}
