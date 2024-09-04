part of 'task_bloc.dart';

sealed class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class CreateEvent extends TaskEvent {
  final TasksModel tasksModel;

  const CreateEvent({
    required this.tasksModel,
  });
  @override
  List<Object> get props => [tasksModel];
}

class UpdateEvent extends TaskEvent {
  final TasksModel tasksModel;

  const UpdateEvent({
    required this.tasksModel,
  });

  @override
  List<Object> get props => [
        tasksModel,
      ];
}

class DeleteEvent extends TaskEvent {
  final TasksModel tasksModel;

  const DeleteEvent({
    required this.tasksModel,
  });

  @override
  List<Object> get props => [
        tasksModel,
      ];
}

class FetchTasks extends TaskEvent {}
