// import 'package:firebase_auth/firebase_auth.dart';

// import '../../res/import/import.dart';

// class AuthenticationProvider extends ChangeNotifier {
//   static AuthenticationProvider? _instance;
//   static late ApiService apiService;
//   static late AuthService service;

//   AuthenticationProvider() {
//     service = AuthHttpService();
//     apiService = ApiServiceImpl();
//   }

//   static AuthenticationProvider get instance {
//     _instance ??= AuthenticationProvider();
//     return _instance!;
//   }

//   // ignore: unused_field
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

//   UserModel? _user;

//   UserModel? get user => _user;

//   Future<void> login({
//     required VoidCallback? onFailure,
//     required VoidCallback? onSuccess,
//     required String email,
//     required String password,
//     required ctx,
//   }) async {
//     try {
//       _user = await service.login(email: email, password: password);
//       if (_user?.email != email || _user?.password != password) {
//         {
//           showErrorToast(
//               message: 'Incorrect email or password. Please try again.',
//               context: ctx);

//           onFailure?.call();
//         }
//       } else {
//         final SharedPreferences prefs = await SharedPreferences.getInstance();
//         await prefs.setString('token', _user?.token ?? '');
//         showSuccessToast(message: 'Login Successful ', context: ctx);
//         await Future.delayed(const Duration(seconds: 2));
//         onSuccess?.call();
//       }
//     } catch (e) {
//       onFailure?.call();
//       rethrow;
//     } finally {
//       notifyListeners();
//     }
//   }

//   Future<void> signup({
//     required String email,
//     required String password,
//   }) async {
//     try {
//       await _firebaseAuth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//     } catch (e) {

//     }
//   }

//   Future<bool> getUser({
//     required String token,
//   }) async {
//     try {
//       _user = await service.getUser(token: token);
//       if (_user?.token != null && _user?.token != '') {
//         return true;
//       } else {
//         return false;
//       }
//     } catch (e) {
//       return false;
//     } finally {
//       notifyListeners();
//     }
//   }

//   Future<void> logOut({
//     required VoidCallback? onFailure,
//     required VoidCallback? onSuccess,
//     required UserModel user,
//   }) async {
//     try {
//       _user = await service.logOut(user: user);
//       final SharedPreferences prefs = await SharedPreferences.getInstance();
//       await prefs.setString('token', '');
//       showSuccessToast(message: 'Logout Successful ', context: context);
//       await Future.delayed(const Duration(seconds: 2));
//       onSuccess?.call();
//     } catch (e) {
//       onFailure?.call();
//     } finally {
//       notifyListeners();
//     }
//   }
// }
