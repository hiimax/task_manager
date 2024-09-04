part of 'task_bloc.dart';

sealed class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

final class TaskInitial extends TaskState {}

final class TaskLoading extends TaskState {}

final class TaskLoaded extends TaskState {
  final List<TasksModel> onlineTasks;
  final List<TasksModel> offlineTasks;
  const TaskLoaded({required this.onlineTasks, required this. offlineTasks});
  @override
  List<Object> get props => [offlineTasks, onlineTasks];
}

final class TaskError extends TaskState {
  final String message;
  const TaskError({required this.message});
  @override
  List<Object> get props => [message];
}

final class TaskSuccess extends TaskState {
  final String message;
  const TaskSuccess({required this.message});
  @override
  List<Object> get props => [message];
}
