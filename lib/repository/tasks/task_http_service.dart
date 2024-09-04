

// import '../../res/import/import.dart';

// class TaskHttpService extends TaskDatabase implements TaskService {
//   @override
//   Future<List<TasksModel>> getAllTasks() async {
//     try {
//       final res = await getAll();
//       return res;
//     } on MyException {
//       rethrow;
//     }
//   }

//   @override
//   Future<List<TasksModel>> updateTasks({required TasksModel tasks}) async {
//     try {
//       await update(tasks);
//         final res = await getAll();
//       return res;
//     } on MyException {
//       rethrow;
//     }
//   }

//   @override
//   Future<List<TasksModel>> addTasks({required TasksModel tasks}) async {
//     try {
//       await insert(tasks);
//        final res = await getAll();
//       return res;
//     } on MyException {
//       rethrow;
//     }
//   }

//   @override
//   Future<bool> deleteTasks({required int id}) async {
//     try {
//       await delete(id);
//       return true;
//     } on MyException {
//       rethrow;
//     }
//   }
// }
