import 'package:task_manager/res/import/import.dart';

abstract class TaskService {
  Future<List<TasksModel>> getAllTasks();
  Future<List<TasksModel>> updateTasks({required TasksModel tasks});
  Future<List<TasksModel>> addTasks({required TasksModel tasks});
  Future<bool> deleteTasks({required int id});
}
