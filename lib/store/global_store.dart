import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';

// 用户信息模型
class UserInfo {
  final String id;
  final String name;
  final String email;
  final String? avatar;
  final String? phone;
  final String? bio;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserInfo({
    required this.id,
    required this.name,
    required this.email,
    this.avatar,
    this.phone,
    this.bio,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      avatar: json['avatar'],
      phone: json['phone'],
      bio: json['bio'],
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updated_at'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatar': avatar,
      'phone': phone,
      'bio': bio,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  UserInfo copyWith({
    String? id,
    String? name,
    String? email,
    String? avatar,
    String? phone,
    String? bio,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserInfo(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
      phone: phone ?? this.phone,
      bio: bio ?? this.bio,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

// 全局状态管理
class GlobalStore extends ChangeNotifier {
  String? _token;
  UserInfo? _userInfo;
  bool _isLoading = false;
  String? _error;

  // Getters
  String? get token => _token;
  UserInfo? get userInfo => _userInfo;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isLoggedIn => _token != null && _token!.isNotEmpty;

  // 初始化
  Future<void> init() async {
    await _loadToken();
    await _loadUserInfo();
  }

  // 加载Token
  Future<void> _loadToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _token = prefs.getString(AppConstants.tokenKey);
      notifyListeners();
    } catch (e) {
      _error = '加载Token失败: $e';
      notifyListeners();
    }
  }

  // 保存Token
  Future<void> _saveToken(String token) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(AppConstants.tokenKey, token);
    } catch (e) {
      _error = '保存Token失败: $e';
      notifyListeners();
    }
  }

  // 加载用户信息
  Future<void> _loadUserInfo() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userInfoJson = prefs.getString(AppConstants.userInfoKey);
      if (userInfoJson != null) {
        final userInfoMap = Map<String, dynamic>.from(
          userInfoJson as Map<String, dynamic>,
        );
        _userInfo = UserInfo.fromJson(userInfoMap);
        notifyListeners();
      }
    } catch (e) {
      _error = '加载用户信息失败: $e';
      notifyListeners();
    }
  }

  // 保存用户信息
  Future<void> _saveUserInfo(UserInfo userInfo) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(AppConstants.userInfoKey, userInfo.toJson().toString());
    } catch (e) {
      _error = '保存用户信息失败: $e';
      notifyListeners();
    }
  }

  // 登录
  Future<void> login(String token, {UserInfo? userInfo}) async {
    _setLoading(true);
    try {
      _token = token;
      await _saveToken(token);
      
      if (userInfo != null) {
        _userInfo = userInfo;
        await _saveUserInfo(userInfo);
      }
      
      _error = null;
      notifyListeners();
    } catch (e) {
      _error = '登录失败: $e';
      notifyListeners();
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  // 更新用户信息
  Future<void> updateUserInfo(UserInfo userInfo) async {
    try {
      _userInfo = userInfo;
      await _saveUserInfo(userInfo);
      notifyListeners();
    } catch (e) {
      _error = '更新用户信息失败: $e';
      notifyListeners();
      rethrow;
    }
  }

  // 登出
  Future<void> logout() async {
    _setLoading(true);
    try {
      _token = null;
      _userInfo = null;
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(AppConstants.tokenKey);
      await prefs.remove(AppConstants.userInfoKey);
      
      _error = null;
      notifyListeners();
    } catch (e) {
      _error = '登出失败: $e';
      notifyListeners();
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  // 设置加载状态
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  // 清除错误
  void clearError() {
    _error = null;
    notifyListeners();
  }

  // 设置错误
  void setError(String error) {
    _error = error;
    notifyListeners();
  }
} 