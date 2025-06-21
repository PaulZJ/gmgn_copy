import 'package:fluttertoast/fluttertoast.dart';
import '../theme/app_theme.dart';

class AppToast {
  // 显示成功消息
  static void showSuccess(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppColors.success,
      textColor: AppColors.textInverse,
      fontSize: 16.0,
    );
  }

  // 显示错误消息
  static void showError(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppColors.error,
      textColor: AppColors.textInverse,
      fontSize: 16.0,
    );
  }

  // 显示警告消息
  static void showWarning(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppColors.warning,
      textColor: AppColors.textInverse,
      fontSize: 16.0,
    );
  }

  // 显示信息消息
  static void showInfo(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppColors.info,
      textColor: AppColors.textInverse,
      fontSize: 16.0,
    );
  }

  // 显示普通消息
  static void show(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppColors.textPrimary,
      textColor: AppColors.textInverse,
      fontSize: 16.0,
    );
  }

  // 取消所有Toast
  static void cancel() {
    Fluttertoast.cancel();
  }
} 