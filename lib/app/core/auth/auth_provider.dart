import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/database/sqlite_connection_factory.dart';
import 'package:todo_list_provider/app/core/navigator/todo_list_navigator.dart';
import 'package:todo_list_provider/app/services/user/user_service.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth;
  final UserService _userService;
  final SqliteConnectionFactory _sqliteConnectionFactory;

  AuthProvider({
    required FirebaseAuth firebaseAuth,
    required UserService userService,
    required SqliteConnectionFactory sqliteConnectionFactory,
  })  : _firebaseAuth = firebaseAuth,
        _userService = userService,
        _sqliteConnectionFactory = sqliteConnectionFactory;

  Future<void> logout() async {
    final conn = await _sqliteConnectionFactory.openConnection();
    await conn.rawDelete('delete from todo');
    _userService.logout();
  }

  User? get user => _firebaseAuth.currentUser;

  void loadListener() {
    //When the notify listeners is called, it notifies the get user method
    _firebaseAuth.userChanges().listen((_) => notifyListeners());
    _firebaseAuth.authStateChanges().listen((user) async {
      //Login
      if (user != null) {
        TodoListNavigator.to.pushNamedAndRemoveUntil('/home', (route) => false);
        //Logout
      } else {
        final conn = await _sqliteConnectionFactory.openConnection();
        await conn.rawDelete('delete from todo');
        TodoListNavigator.to.pushNamedAndRemoveUntil('/login', (route) => false);
      }
    });
  }
}
