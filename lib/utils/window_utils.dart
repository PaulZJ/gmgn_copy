import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WindowUtils {
  // 设置状态栏样式
  static void setStatusBarStyle(Brightness brightness) {
    if (!kIsWeb) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: brightness == Brightness.light 
              ? Brightness.dark 
              : Brightness.light,
        ),
      );
    }
  }

  // 设置系统UI样式
  static void setSystemUIStyle({
    bool transparentStatusBar = true,
    bool transparentNavigationBar = false,
  }) {
    if (!kIsWeb) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: transparentStatusBar 
              ? Colors.transparent 
              : null,
          systemNavigationBarColor: transparentNavigationBar 
              ? Colors.transparent 
              : null,
        ),
      );
    }
  }

  // 设置首选方向
  static Future<void> setPreferredOrientations(List<DeviceOrientation> orientations) async {
    if (!kIsWeb) {
      await SystemChrome.setPreferredOrientations(orientations);
    }
  }

  // 设置系统UI可见性
  static void setSystemUIVisibility(SystemUiMode mode) {
    if (!kIsWeb) {
      SystemChrome.setEnabledSystemUIMode(mode);
    }
  }

  // 获取系统信息
  static Map<String, dynamic> getSystemInfo() {
    return {
      'platform': defaultTargetPlatform.toString(),
      'isWeb': kIsWeb,
      'isMobile': defaultTargetPlatform == TargetPlatform.android || 
                  defaultTargetPlatform == TargetPlatform.iOS,
      'isDesktop': defaultTargetPlatform == TargetPlatform.windows || 
                   defaultTargetPlatform == TargetPlatform.macOS || 
                   defaultTargetPlatform == TargetPlatform.linux,
    };
  }

  // 复制到剪贴板
  static Future<void> copyToClipboard(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
  }

  // 从剪贴板获取文本
  static Future<String?> getClipboardText() async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    return data?.text;
  }

  // 震动反馈
  static void vibrate({int milliseconds = 100}) {
    if (!kIsWeb) {
      HapticFeedback.lightImpact();
    }
  }

  // 长震动反馈
  static void vibrateLong() {
    if (!kIsWeb) {
      HapticFeedback.heavyImpact();
    }
  }
} 