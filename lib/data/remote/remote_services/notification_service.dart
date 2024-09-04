import 'package:task_manager/res/import/import.dart';

abstract class NotificationService {
  Future<List<NotificationModel>> getAllNotification();
  Future<List<NotificationModel>> updateNotification(
      {required NotificationModel notification});
  Future<List<NotificationModel>> addNotification(
      {required NotificationModel notification});
  Future<bool> deleteNotification({required int id});
}
