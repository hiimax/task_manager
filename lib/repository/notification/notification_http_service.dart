



import '../../res/import/import.dart';

class NotificationHttpService extends NotificationDataBase implements NotificationService {
  @override
  Future<List<NotificationModel>> getAllNotification() async {
    try {
      final res = await getAll();
      return res;
    } on MyException {
      rethrow;
    }
  }

  @override
  Future<List<NotificationModel>> updateNotification({required NotificationModel notification}) async {
    try {
      await update(notification);
        final res = await getAll();
      return res;
    } on MyException {
      rethrow;
    }
  }

  @override
  Future<List<NotificationModel>> addNotification({required NotificationModel notification}) async {
    try {
      await insert(notification);
       final res = await getAll();
      return res;
    } on MyException {
      rethrow;
    }
  }

  @override
  Future<bool> deleteNotification({required int id}) async {
    try {
      await delete(id);
      return true;
    } on MyException {
      rethrow;
    }
  }
}
