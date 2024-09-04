import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:task_manager/data/database/task_db.dart';
import 'package:task_manager/models/user_model.dart';
import 'package:uuid/uuid.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

GetIt locator = GetIt.instance;

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    final firebaseAuth = FirebaseAuth.instance;
    firebaseAuth.signOut();
    on<SignupEvent>((event, emit) async {
      emit(Loading());
      try {
        await firebaseAuth.signOut();
        if (!(await checkIfUserExists(event.email))) {
          final user = await firebaseAuth.createUserWithEmailAndPassword(
            email: event.email,
            password: event.password,
          );
          await signUp(email: event.email, fullName: event.fullName);

          emit(SignupSuccess(user.user!));
        } else {
          emit(SignupError('User already exists'));
        }
      } on FirebaseAuthException catch (e) {
        emit(SignupError(e.message.toString()));
      }
    });
    on<LoginEvent>((event, emit) async {
      emit(Loading());
      try {
        final user = await firebaseAuth.signInWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
        UserModel? userModel = await login(email: event.email);
        locator.registerLazySingleton<TaskDatabase>(
          () => TaskDatabase('${user.user?.uid}'),
          instanceName: '${user.user?.uid}',
        );
        emit(LoginSuccess(user.user!, userModel));
      } on FirebaseAuthException catch (e) {
        emit(LoginError(e.message ?? ''));
      }
    });
    on<ResetPasswordEvent>((event, emit) async {
        emit(Loading());
      try {
        if (await checkIfUserExists(event.email)) {
          await firebaseAuth.sendPasswordResetEmail(email: event.email);
          emit(ResetPassowrdSuccess(
              'Password reset email sent. Please check your email.'));
        } else {
          emit(ResetPassowrdError('User not found'));
        }
      } on FirebaseAuthException catch (e) {
        emit(ResetPassowrdError(e.message ?? ''));
      }
    });
  }

  Future<bool> checkIfUserExists(String email) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    QuerySnapshot querySnapshot = await users.get();
    for (var doc in querySnapshot.docs) {
      if (doc['email'] == email) {
        return true;
      }
    }
    return false;
  }

  Future<void> signUp({
    required String email,
    required String fullName,
  }) async {
    final users = FirebaseFirestore.instance.collection('users').doc(email);
    final uuid = const Uuid().v4();
    await users.set({
      'email': email,
      'fullName': fullName,
      'uuid': uuid,
      'created': DateTime.now().toIso8601String(),
      'updated': DateTime.now().toIso8601String(),
    });
  }

  Future<UserModel?> login({
    required String email,
  }) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    UserModel? user;
    // Retrieve one documents in the 'users' collection
    DocumentSnapshot documentSnapshot = await users.doc(email).get();
    if (documentSnapshot.exists) {
      // Update the document
      user =
          UserModel.fromJson(documentSnapshot.data() as Map<String, dynamic>);
    }
    return user;
  }
}
