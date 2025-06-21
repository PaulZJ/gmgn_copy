// 应用常量定义
class AppConstants {
  // 应用信息
  static const String appName = 'GMGN Demo';
  static const String appVersion = '1.0.0';
  
  // API 相关
  static const String baseUrl = 'https://api.example.com';
  static const int apiTimeout = 30000; // 30秒
  
  // 本地存储键
  static const String tokenKey = 'token';
  static const String userInfoKey = 'user_info';
  static const String themeKey = 'theme_mode';
  
  // 路由名称
  static const String homeRoute = '/';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String profileRoute = '/profile';
  
  // 动画时长
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 500);
  
  // 分页
  static const int pageSize = 20;
  static const int maxPageSize = 100;
  
  // 文件上传
  static const int maxFileSize = 10 * 1024 * 1024; // 10MB
  static const List<String> allowedImageTypes = ['jpg', 'jpeg', 'png', 'gif', 'webp'];
  static const List<String> allowedDocumentTypes = ['pdf', 'doc', 'docx', 'txt'];
  
  // 缓存配置
  static const int imageCacheSize = 100;
  static const int imageCacheSizeBytes = 50 * 1024 * 1024; // 50MB
  
  // 错误消息
  static const String networkError = '网络连接失败，请检查网络设置';
  static const String serverError = '服务器错误，请稍后重试';
  static const String unknownError = '未知错误，请稍后重试';
  static const String invalidInput = '输入格式不正确';
  static const String permissionDenied = '权限不足';
} 