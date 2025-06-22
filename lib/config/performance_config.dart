import 'package:flutter/foundation.dart';

/// 性能配置类
class PerformanceConfig {
  // 是否启用性能优化
  static const bool enablePerformanceOptimizations = true;
  
  // 图片缓存配置
  static const int imageCacheSize = 100;
  static const int imageCacheSizeBytes = 50 * 1024 * 1024; // 50MB
  
  // 网络请求配置
  static const int networkTimeout = 30000; // 30秒
  static const int maxRetries = 3;
  
  // 动画配置
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 500);
  
  // 启动配置
  static const Duration splashScreenDuration = Duration(milliseconds: 1500);
  static const Duration initializationTimeout = Duration(seconds: 10);
  
  // Web特定配置
  static const bool enableWebOptimizations = kIsWeb;
  static const bool preloadCriticalResources = kIsWeb;
  
  // 调试配置
  static const bool enablePerformanceLogging = kDebugMode;
  
  /// 获取平台特定的优化配置
  static Map<String, dynamic> getPlatformOptimizations() {
    if (kIsWeb) {
      return {
        'enableServiceWorker': true,
        'enableCaching': true,
        'enableCompression': true,
        'enableLazyLoading': true,
      };
    } else {
      return {
        'enableServiceWorker': false,
        'enableCaching': true,
        'enableCompression': false,
        'enableLazyLoading': true,
      };
    }
  }
  
  /// 获取缓存配置
  static Map<String, dynamic> getCacheConfig() {
    return {
      'imageCache': {
        'maxSize': imageCacheSize,
        'maxSizeBytes': imageCacheSizeBytes,
      },
      'networkCache': {
        'maxSize': 100 * 1024 * 1024, // 100MB
        'maxAge': const Duration(days: 7),
      },
      'localStorage': {
        'maxSize': 10 * 1024 * 1024, // 10MB
      },
    };
  }
  
  /// 获取动画配置
  static Map<String, Duration> getAnimationConfig() {
    return {
      'short': shortAnimation,
      'medium': mediumAnimation,
      'long': longAnimation,
    };
  }
} 