class ApiRoutes {
  ApiRoutes._();

  static const baseUrl =
      'https://taskManager-82b1d7c41978.herokuapp.com/api/v1';

  // Authentication
  static const login = '$baseUrl/users/login';
  static const signup = '$baseUrl/users';
  static const forgetPassword = '$baseUrl/users/forgot-password';
  static const setTransactionPin = '$baseUrl/users/set-transaction-pin';
  static const getAllOtp = '$baseUrl/users/otp/getAll';
  static const verifyOtp = '$baseUrl/users/otp/verify/:otp_for';
  static const resetPassword = '$baseUrl/users/reset-password';
}
