// import '../../res/import/import.dart';

// class TasksProvider extends ChangeNotifier {
//   static TasksProvider? _instance;
//   static late ApiService apiService;
//   static late TaskService service;

//   TasksProvider() {
//     service = TaskHttpService();
//     apiService = ApiServiceImpl();
//   }

//   static TasksProvider get instance {
//     _instance ??= TasksProvider();
//     return _instance!;
//   }

//   TasksModel? _task;

//   TasksModel? get task => _task;

//   List<TasksModel>? _tasks;

//   List<TasksModel>? get tasks => _tasks;

//   Future<void> initiateGetTask() async {
//     try {
//       _tasks = await service.getAllTasks();
//     } finally {
//       notifyListeners();
//     }
//   }

//   Future<void> getAllTasks({
//     required VoidCallback? onFailure,
//     required VoidCallback? onSuccess,
//     required ctx,
//   }) async {
//     try {
//       _tasks = await service.getAllTasks();
//       if (_task == null) {
//         {
//           showErrorToast(
//               message: 'Unable to fetch tasks. Please try again.',
//               context: ctx);

//           onFailure?.call();
//         }
//       } else {
//         showSuccessToast(message: 'Tasks Fetched ', context: ctx);
//         onSuccess?.call();
//       }
//     } catch (e) {
//       onFailure?.call();
//       rethrow;
//     } finally {
//       notifyListeners();
//     }
//   }

//   Future<void> updateTasks({
//     required VoidCallback? onFailure,
//     required VoidCallback? onSuccess,
//     required TasksModel tasks,
//     required ctx,
//   }) async {
//     try {
//       _tasks = await service.updateTasks(tasks: tasks);
//       showSuccessToast(message: 'Task Updated ', context: ctx);
//       onSuccess?.call();
//       return;
//     } catch (e) {
//       onFailure?.call();
//       rethrow;
//     } finally {
//       notifyListeners();
//     }
//   }

//   Future<void> addTasks({
//     required VoidCallback? onFailure,
//     required VoidCallback? onSuccess,
//     required TasksModel tasks,
//     required ctx,
//   }) async {
//     try {
//       _tasks = await service.addTasks(tasks: tasks);
//       showSuccessToast(message: 'Task Added ', context: ctx);
//       onSuccess?.call();
//       return;
//     } catch (e) {
//       onFailure?.call();
//       rethrow;
//     } finally {
//       notifyListeners();
//     }
//   }

//   Future<void> deleteTasks({
//     required VoidCallback? onFailure,
//     required VoidCallback? onSuccess,
//     required int id,
//     required ctx,
//   }) async {
//     try {
//       bool isDeleted = await service.deleteTasks(id: id);
//       if (isDeleted) {
//         showSuccessToast(message: 'Task Deleted ', context: ctx);
//         _tasks = await service.getAllTasks();
//         onSuccess?.call();
//       } else {
//         showErrorToast(message: 'Unable to delete task', context: ctx);
//         onFailure?.call();
//       }
//     } catch (e) {
//       onFailure?.call();
//     } finally {
//       notifyListeners();
//     }
//   }
// }
