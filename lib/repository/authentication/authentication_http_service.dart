
// import '../../res/import/import.dart';

// class AuthHttpService extends AuthDataBase implements AuthService {
//   @override
//   Future<UserModel?> login(
//       {required String email, required String password}) async {
//     try {
//       final res = await read(colEmail, email);
//       return res;
//     } on MyException {
//       rethrow;
//     }
//   }

//   @override
//   Future<UserModel?> signup({required UserModel user}) async {
//     try {
//       await insert(user);
//       final res = await read(colEmail, user.email ?? '');
//       return res;
//     } on MyException {
//       rethrow;
//     }
//   }

//   @override
//   Future<UserModel?> getUser({required String token}) async {
//     try {
//       final res = await read(colToken, token);
//       return res;
//     } on MyException {
//       rethrow;
//     }
//   }

//   @override
//   Future<UserModel?> queryDB({required String email}) async {
//     try {
//       final res = await read(colEmail, email);
//       return res;
//     } on MyException {
//       rethrow;
//     }
//   }

//   @override
//   Future<UserModel?> logOut({required UserModel user}) async {
//     try {
//       await update(user);
//       final res = await read(colEmail, user.email ?? '');
//       return res;
//     } on MyException {
//       rethrow;
//     }
//   }
// }
