# GMGN Demo

一个现代化的 Flutter 应用脚手架，采用最佳实践的项目结构和开发模式。

## 项目结构

```
lib/
├── constants.dart              # 应用常量定义
├── main.dart                   # 应用入口文件
├── router.dart                 # 路由配置
├── config/                     # 配置文件
├── extension/                  # 扩展方法
├── pages/                      # 页面组件
│   ├── home/                   # 首页
│   ├── account/                # 账户相关页面
│   ├── create_page/            # 创建页面
│   ├── management/             # 管理页面
│   ├── main_layout/            # 主布局
│   └── ...
├── services/                   # 服务层
├── store/                      # 状态管理
├── theme/                      # 主题配置
├── uikit/                      # UI组件
├── utils/                      # 工具类
└── widgets/                    # 通用组件
```

## 功能特性

- 🎨 **现代化UI设计** - 使用Material 3设计语言
- 🌙 **深色模式支持** - 自动跟随系统主题
- 🚀 **路由管理** - 基于go_router的声明式路由
- 📱 **状态管理** - 使用Provider进行状态管理
- 🔐 **用户认证** - 登录、注册、个人资料管理
- 📦 **依赖管理** - 完整的依赖配置
- 🎯 **代码规范** - 遵循Flutter最佳实践

## 主要依赖

- **路由**: go_router
- **状态管理**: provider
- **UI组件**: flutter_smart_dialog, flutter_easyloading
- **网络**: cached_network_image, url_launcher
- **存储**: shared_preferences, path_provider
- **认证**: firebase_auth, google_sign_in
- **工具**: flutter_hooks, intl, uuid

## 快速开始

1. **克隆项目**
   ```bash
   git clone <repository-url>
   cd gmgn_demo
   ```

2. **安装依赖**
   ```bash
   flutter pub get
   ```

3. **运行项目**
   ```bash
   flutter run
   ```

## 开发指南

### 添加新页面

1. 在 `lib/pages/` 下创建页面目录
2. 在 `lib/router.dart` 中添加路由配置
3. 实现页面组件

### 添加新服务

1. 在 `lib/services/` 下创建服务文件
2. 实现服务逻辑
3. 在需要的地方注入使用

### 主题定制

1. 修改 `lib/theme/app_theme.dart` 中的颜色配置
2. 更新 `lib/constants.dart` 中的常量

## 项目配置

### Firebase配置

如需使用Firebase功能，请：

1. 在Firebase控制台创建项目
2. 下载配置文件
3. 更新 `lib/main.dart` 中的Firebase配置

### 环境配置

- 开发环境: `flutter run`
- 生产环境: `flutter build`

## 贡献指南

1. Fork 项目
2. 创建功能分支
3. 提交更改
4. 推送到分支
5. 创建 Pull Request

## 许可证

MIT License

## 联系方式

如有问题或建议，请提交 Issue 或联系开发团队。
