import 'package:task_manager/models/user_model.dart';

abstract class AuthService {
  Future<UserModel?> login({required String email, required String password});
  Future<UserModel?> signup({required UserModel user});
  Future<UserModel?> getUser({required String token});
  Future<UserModel?> queryDB({required String email});
  Future<UserModel?> logOut({required UserModel user});
}
