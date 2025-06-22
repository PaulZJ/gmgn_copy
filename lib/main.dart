import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

import 'constants.dart';
import 'config/performance_config.dart';
import 'router.dart';
import 'store/global_store.dart';
import 'theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 设置URL策略（Web端）
  if (kIsWeb) {
    setPathUrlStrategy();
  }

  // 配置图片缓存
  PaintingBinding.instance.imageCache.maximumSize = PerformanceConfig.imageCacheSize;
  PaintingBinding.instance.imageCache.maximumSizeBytes = PerformanceConfig.imageCacheSizeBytes;

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GlobalStore? _globalStore;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    // 异步初始化全局状态
    final globalStore = GlobalStore();
    
    // 设置超时时间
    await globalStore.init().timeout(
      PerformanceConfig.initializationTimeout,
      onTimeout: () {
        if (PerformanceConfig.enablePerformanceLogging) {
          print('初始化超时，继续启动应用');
        }
      },
    );
    
    if (mounted) {
      setState(() {
        _globalStore = globalStore;
        _isInitialized = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized || _globalStore == null) {
      // 显示启动画面
      return MaterialApp(
        title: AppConstants.appName,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      );
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _globalStore!),
      ],
      child: MaterialApp.router(
        title: AppConstants.appName,
        routerConfig: router,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system, // 跟随系统主题
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          // 初始化SmartDialog
          child = FlutterSmartDialog.init(
            builder: (context, child) {
              return Overlay(
                initialEntries: [
                  OverlayEntry(
                    builder: (context) => child!,
                  ),
                ],
              );
            },
          )(context, child);
          
          // 初始化EasyLoading
          child = EasyLoading.init()(context, child);
          
          // 设置文本缩放
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: const TextScaler.linear(1.0),
            ),
            child: child,
          );
        },
      ),
    );
  }
}

// 启动画面
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: PerformanceConfig.splashScreenDuration,
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    
    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo或图标
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.rocket_launch,
                        size: 40,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      AppConstants.appName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const SizedBox(
                      width: 40,
                      height: 40,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        strokeWidth: 3,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
