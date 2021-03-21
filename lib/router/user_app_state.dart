import 'package:flutter/material.dart';
import 'package:remottely/models/current_user_model.dart';

class UsersAppState extends ChangeNotifier {
  int _selectedIndex;

  User _privateSelectedUser;

  final List<User> users = [
    User('kevinkobori', '24'),
    User('joy', '23'),
    User('leandro', '21'),
  ];

  UsersAppState() : _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  set selectedIndex(int idx) {
    // if (_selectedIndex == idx) {
    //   // return;
    //   // _selectedIndex = 4;
    // } else {
    // }
      _selectedIndex = idx;
    if (_selectedIndex != 0) {
      // Remove this line if you want to keep the selected user when navigating
      // between "" and "home" which user was selected when  is
      // tapped.
      selectedUser = null;
    }
    notifyListeners();
  }

  User get selectedUser => _privateSelectedUser;

  set selectedUser(User user) {
    _privateSelectedUser = user;
    notifyListeners();
  }

  int getSelectedUserById() {
    if (!users.contains(_privateSelectedUser)) return 0;
    return users.indexOf(_privateSelectedUser);
  }

  void setSelectedUserById(int id) {
    if (id < 0 || id > users.length - 1) {
      return;
    }

    _privateSelectedUser = users[id];
    notifyListeners();
  }
}
