import 'package:firebase_auth/firebase_auth.dart';

import 'package:todo_list_provider/app/repositories/user/user_repository.dart';

import './user_service.dart';

class UserServiceImpl implements UserService {
  final UserRepository _userRepository;

  const UserServiceImpl({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  @override
  Future<User?> register(String email, String password) =>
      _userRepository.register(email, password);

  @override
  Future<User?> login(String email, String password) =>
      _userRepository.login(email, password);
}
