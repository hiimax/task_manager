import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:task_manager/bloc/authentication/authentication_bloc.dart';
import 'package:task_manager/data/database/task_db.dart';
import 'package:task_manager/models/task_model.dart';
import 'package:task_manager/res/view_route/route_generator.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> with DatabaseSync {
  @override
  late final TaskDatabase database;
  TaskBloc() : super(TaskInitial()) {
    database = locator.get<TaskDatabase>(
      instanceName: '${FirebaseAuth.instance.currentUser?.uid}',
    );
    on<FetchTasks>((event, emit) async {
      emit(TaskLoading());
      final onlineTasks = await database.getOnlineTasks();
      final localTasks = await database.getLocalTasks();
      emit(TaskLoaded(onlineTasks: onlineTasks, offlineTasks: localTasks));
      // compareAndSync();
    });
    on<CreateEvent>((event, emit) async {
      try {
        emit(TaskLoading());
        await database.insert(event.tasksModel);
        log(event.tasksModel.toString(), name: 'Task Added');
        emit(const TaskSuccess(message: ' Task Added'));
        final onlineTasks = await database.getOnlineTasks();
        final localTasks = await database.getLocalTasks();
        emit(TaskLoaded(onlineTasks: onlineTasks, offlineTasks: localTasks));
        compareAndSync();
      } catch (e) {
        emit(TaskError(message: e.toString()));
      }
    });

    on<UpdateEvent>((event, emit) async {
      try {
        emit(TaskLoading());
        await database.update(event.tasksModel);
        emit(const TaskSuccess(message: 'Task Updated'));
        final onlineTasks = await database.getOnlineTasks();
        final localTasks = await database.getLocalTasks();
        emit(TaskLoaded(onlineTasks: onlineTasks, offlineTasks: localTasks));
        compareAndSync();
      } catch (e) {
        emit(TaskError(message: e.toString()));
      }
    });

    on<DeleteEvent>((event, emit) async {
      try {
        emit(TaskLoading());
        await database.update(event.tasksModel);
        emit(const TaskSuccess(message: 'Task Deleted'));
        final onlineTasks = await database.getOnlineTasks();
        final localTasks = await database.getLocalTasks();
        emit(TaskLoaded(onlineTasks: onlineTasks, offlineTasks: localTasks));
        compareAndSync();
      } catch (e) {
        emit(TaskError(message: e.toString()));
      }
    });
  }
}

mixin DatabaseSync {
  final database = locator.get<TaskDatabase>(
    instanceName: '${FirebaseAuth.instance.currentUser?.uid}',
  );
  final snapshot = FirebaseFirestore.instance
      .collection('tasks')
      .where('userId', isEqualTo: FirebaseAuth.instance.currentUser?.uid);
  Future<List<TasksModel>> _fetchRemoteData() async {
    try {
      List<TasksModel> tasks = [];

      final querySnapshot = await snapshot.get();
      for (var doc in querySnapshot.docs) {
        tasks.add(TasksModel.fromJson(doc.data()));
      }
      return tasks;
    } catch (e) {
      return [];
    }
  }

  Future<List<TasksModel>> _fetchLocalData() async {
    return database.getLocalTasks();
  }

  Future<void> compareAndSync() async {
    final isConnected = await InternetConnectionChecker().hasConnection;

    if (isConnected) {
      final remoteData = await _fetchRemoteData();
      final localData = await _fetchLocalData();

      for (var item in remoteData) {
        final existsInLocalDb = localData
            .any((element) => element.id.toString() == item.id.toString());
        log(existsInLocalDb.toString(), name: 'exists in local db');
        log(item.id.toString(), name: 'exists in local db');
        if (!existsInLocalDb) {
          await database.insert(item);
        }
      }

      for (var item in localData) {
        if (item.isSynced == 'false') {
          log('ready');
          try {
            await FirebaseFirestore.instance
                .collection('tasks')
                .doc(item.id)
                .set(
                  item.toJson()
                    ..addEntries(
                      {
                        MapEntry(
                            'userId', FirebaseAuth.instance.currentUser?.uid),
                        const MapEntry('is_synced', 'true'),
                      },
                    ),
                );
            await database.update(item.copyWith(isSynced: 'true'));
          } catch (e) {
            log(e.toString(), name: 'sync error');
          }
        }
      }
    }
    rootNavigatorKey.currentContext!.read<TaskBloc>().add(FetchTasks());
  }
}
