import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'pages/home/home_page.dart';
import 'pages/account/login_page.dart';
import 'pages/account/register_page.dart';
import 'pages/account/profile_page.dart';
import 'pages/main_layout/main_layout.dart';

// 路由配置
final router = GoRouter(
  initialLocation: '/',
  routes: [
    // 主布局路由
    ShellRoute(
      builder: (context, state, child) => MainLayout(child: child),
      routes: [
        // 首页
        GoRoute(
          path: '/',
          name: 'home',
          builder: (context, state) => const HomePage(),
        ),
        // 创建页面
        GoRoute(
          path: '/create',
          name: 'create',
          builder: (context, state) => const Scaffold(
            body: Center(
              child: Text('创建页面'),
            ),
          ),
        ),
        // 管理页面
        GoRoute(
          path: '/management',
          name: 'management',
          builder: (context, state) => const Scaffold(
            body: Center(
              child: Text('管理页面'),
            ),
          ),
        ),
        // 个人资料
        GoRoute(
          path: '/profile',
          name: 'profile',
          builder: (context, state) => const ProfilePage(),
        ),
      ],
    ),
    // 登录页面（独立路由，不在主布局中）
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginPage(),
    ),
    // 注册页面（独立路由，不在主布局中）
    GoRoute(
      path: '/register',
      name: 'register',
      builder: (context, state) => const RegisterPage(),
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.red,
          ),
          const SizedBox(height: 16),
          Text(
            '页面未找到',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            '路径: ${state.uri}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => context.go('/'),
            child: const Text('返回首页'),
          ),
        ],
      ),
    ),
  ),
);

// 路由守卫
class RouteGuard {
  static bool canAccess(String path, {String? token}) {
    // 需要登录的页面
    final protectedRoutes = ['/profile', '/management', '/create'];
    
    if (protectedRoutes.contains(path)) {
      return token != null && token.isNotEmpty;
    }
    
    return true;
  }
}

// 路由扩展方法
extension RouterExtension on BuildContext {
  void goToHome() => go('/');
  void goToLogin() => go('/login');
  void goToRegister() => go('/register');
  void goToProfile() => go('/profile');
  void goToCreate() => go('/create');
  void goToManagement() => go('/management');
  
  void goBack() {
    if (canPop()) {
      pop();
    } else {
      go('/');
    }
  }
} 