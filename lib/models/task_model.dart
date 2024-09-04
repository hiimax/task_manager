import 'package:equatable/equatable.dart';

class TasksModel extends Equatable {
  final String id;

  String? title, description, category, createdAt, updatedAt, dueAt, reminder;
  String isSynced, isDeleted;

  TasksModel({
    this.title,
    this.description,
    this.category,
    this.createdAt,
    this.updatedAt,
    this.dueAt,
    this.reminder,
    this.isDeleted = 'false',
    required this.id,
    this.isSynced = 'false',
  });

  factory TasksModel.fromJson(Map<String, dynamic> map) {
    return TasksModel(
      id: map['uid'],
      title: map['title'],
      description: map['description'],
      category: map['category'],
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
      dueAt: map['due_at'],
      reminder: map['reminder'],
      isDeleted: map['is_deleted'],
      isSynced: map['is_synced'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'category': category,
      'uid': id,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'reminder': reminder,
      'due_at': dueAt,
      'is_deleted': isDeleted,
      'is_synced': isSynced
    };
  }

  @override
  String toString() {
    return '''
        title: $title
        description: $description
        category: $category
        id: $id
        created_at: $createdAt
        updated_at: $updatedAt
        reminder: $reminder
        due_at: $dueAt
        is_deleted: $isDeleted
        is_synced: $isSynced
        ''';
  }

  TasksModel copyWith(
      {String? title,
      String? description,
      String? category,
      String? id,
      String? createdAt,
      String? updatedAt,
      String? dueAt,
      String? reminder,
      String? isDeleted,
      String? isSynced}) {
    return TasksModel(
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      dueAt: dueAt ?? this.dueAt,
      reminder: reminder ?? this.reminder,
      isDeleted: isDeleted ?? this.isDeleted,
      isSynced: isSynced ?? this.isSynced,
    );
  }

  @override
  List<Object?> get props => [id];
}
