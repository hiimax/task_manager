import '../../res/import/import.dart';

class NotificationProvider extends ChangeNotifier {
  static NotificationProvider? _instance;
  static late ApiService apiService;
  static late NotificationService service;

  NotificationProvider() {
    service = NotificationHttpService();
    apiService = ApiServiceImpl();
  }

  static NotificationProvider get instance {
    _instance ??= NotificationProvider();
    return _instance!;
  }

  NotificationModel? _notification;

  NotificationModel? get notification => _notification;

  List<NotificationModel>? _notifications;

  List<NotificationModel>? get notifications => _notifications;

  Future<void> initiateGetNotification() async {
    try {
      _notifications = await service.getAllNotification();
    } finally {
      notifyListeners();
    }
  }

  Future<void> getAllNotification({
    required VoidCallback? onFailure,
    required VoidCallback? onSuccess,
    required ctx,
  }) async {
    try {
      _notifications = await service.getAllNotification();
      if (_notification == null) {
        {
          showErrorToast(
              message: 'Unable to fetch notifications. Please try again.',
              context: ctx);

          onFailure?.call();
        }
      } else {
        showSuccessToast(message: 'Notifications Fetched ', context: ctx);
        onSuccess?.call();
      }
    } catch (e) {
      onFailure?.call();
    } finally {
      notifyListeners();
    }
  }

  Future<void> updateNotification({
    required VoidCallback? onFailure,
    required VoidCallback? onSuccess,
    required NotificationModel notification,
    required ctx,
  }) async {
    try {
      _notifications = await service.updateNotification(notification: notification);
      showSuccessToast(message: 'Notification Updated ', context: ctx);
      onSuccess?.call();
      return;
    } catch (e) {
      onFailure?.call();
    } finally {
      notifyListeners();
    }
  }

  Future<void> addNotification({
    required VoidCallback? onFailure,
    required VoidCallback? onSuccess,
    required NotificationModel notification,
    required ctx,
  }) async {
    try {
      _notifications = await service.addNotification(notification: notification);
      showSuccessToast(message: 'Notification Added ', context: ctx);
      onSuccess?.call();
      return;
    } catch (e) {
      onFailure?.call();
       rethrow;
    } finally {
      notifyListeners();
    }
  }

  Future<void> deleteNotification({
    required VoidCallback? onFailure,
    required VoidCallback? onSuccess,
    required int id,
    required ctx,
  }) async {
    try {
      bool isDeleted = await service.deleteNotification(id: id);
      if (isDeleted) {
        showSuccessToast(message: 'Notification Deleted ', context: ctx);
        _notifications = await service.getAllNotification();
        onSuccess?.call();
      } else {
        showErrorToast(message: 'Unable to delete notification', context: ctx);
        onFailure?.call();
      }
    } catch (e) {
      onFailure?.call();
    } finally {
      notifyListeners();
    }
  }
}
