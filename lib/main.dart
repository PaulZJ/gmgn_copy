import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:url_strategy/url_strategy.dart';

import 'constants.dart';
import 'router.dart';
import 'store/global_store.dart';
import 'theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 设置URL策略（Web端）
  if (kIsWeb) {
    setPathUrlStrategy();
  }

  // 初始化全局状态
  final globalStore = GlobalStore();
  await globalStore.init();

  // 初始化Firebase（可选）
  try {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "your-api-key",
        authDomain: "your-auth-domain",
        projectId: "your-project-id",
        storageBucket: "your-storage-bucket",
        messagingSenderId: "your-messaging-sender-id",
        appId: "your-app-id",
        measurementId: "your-measurement-id",
      ),
    );

    // 初始化Analytics
    final analytics = FirebaseAnalytics.instance;
    await analytics.setAnalyticsCollectionEnabled(true);
  } catch (e) {
    if (kDebugMode) {
      print('Firebase初始化失败: $e');
    }
  }

  // 配置图片缓存
  PaintingBinding.instance.imageCache.maximumSize = AppConstants.imageCacheSize;
  PaintingBinding.instance.imageCache.maximumSizeBytes = AppConstants.imageCacheSizeBytes;

  runApp(MyApp(globalStore: globalStore));
}

class MyApp extends StatefulWidget {
  final GlobalStore globalStore;

  const MyApp({
    super.key,
    required this.globalStore,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    
    // 配置EasyLoading
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.wave
      ..loadingStyle = EasyLoadingStyle.custom
      ..userInteractions = false
      ..indicatorSize = 30
      ..backgroundColor = Colors.transparent
      ..indicatorColor = AppColors.primary
      ..textColor = Colors.transparent
      ..boxShadow = <BoxShadow>[]
      ..maskType = EasyLoadingMaskType.black
      ..dismissOnTap = false;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: widget.globalStore),
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
