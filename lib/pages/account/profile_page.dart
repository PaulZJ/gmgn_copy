import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_theme.dart';
import '../../constants.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // 模拟用户数据
  final Map<String, dynamic> _userInfo = {
    'name': '张三',
    'email': 'zhangsan@example.com',
    'avatar': null,
    'phone': '13800138000',
    'bio': '这是一个示例用户',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('个人资料'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // TODO: 实现设置功能
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 头像和基本信息
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // 头像
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: AppColors.primary.withOpacity(0.1),
                      child: _userInfo['avatar'] != null
                          ? ClipOval(
                              child: Image.network(
                                _userInfo['avatar'],
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(
                                    Icons.person,
                                    size: 50,
                                    color: AppColors.primary,
                                  );
                                },
                              ),
                            )
                          : Icon(
                              Icons.person,
                              size: 50,
                              color: AppColors.primary,
                            ),
                    ),
                    const SizedBox(height: 16),
                    
                    // 用户名
                    Text(
                      _userInfo['name'],
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    
                    // 邮箱
                    Text(
                      _userInfo['email'],
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // 编辑按钮
                    OutlinedButton.icon(
                      onPressed: () {
                        // TODO: 实现编辑资料功能
                      },
                      icon: const Icon(Icons.edit),
                      label: const Text('编辑资料'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // 功能列表
            Card(
              child: Column(
                children: [
                  _buildListTile(
                    context,
                    icon: Icons.person,
                    title: '账户信息',
                    subtitle: '管理您的账户信息',
                    onTap: () {
                      // TODO: 跳转到账户信息页面
                    },
                  ),
                  _buildListTile(
                    context,
                    icon: Icons.notifications,
                    title: '通知设置',
                    subtitle: '管理通知偏好',
                    onTap: () {
                      // TODO: 跳转到通知设置页面
                    },
                  ),
                  _buildListTile(
                    context,
                    icon: Icons.security,
                    title: '隐私与安全',
                    subtitle: '管理隐私和安全设置',
                    onTap: () {
                      // TODO: 跳转到隐私设置页面
                    },
                  ),
                  _buildListTile(
                    context,
                    icon: Icons.language,
                    title: '语言设置',
                    subtitle: '选择应用语言',
                    onTap: () {
                      // TODO: 跳转到语言设置页面
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            
            // 数据管理
            Card(
              child: Column(
                children: [
                  _buildListTile(
                    context,
                    icon: Icons.download,
                    title: '数据导出',
                    subtitle: '导出您的数据',
                    onTap: () {
                      // TODO: 实现数据导出功能
                    },
                  ),
                  _buildListTile(
                    context,
                    icon: Icons.delete,
                    title: '删除账户',
                    subtitle: '永久删除您的账户',
                    onTap: () {
                      _showDeleteAccountDialog(context);
                    },
                    textColor: AppColors.error,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            
            // 应用信息
            Card(
              child: Column(
                children: [
                  _buildListTile(
                    context,
                    icon: Icons.info,
                    title: '关于应用',
                    subtitle: '版本 ${AppConstants.appVersion}',
                    onTap: () {
                      // TODO: 跳转到关于页面
                    },
                  ),
                  _buildListTile(
                    context,
                    icon: Icons.help,
                    title: '帮助与支持',
                    subtitle: '获取帮助信息',
                    onTap: () {
                      // TODO: 跳转到帮助页面
                    },
                  ),
                  _buildListTile(
                    context,
                    icon: Icons.description,
                    title: '用户协议',
                    subtitle: '查看用户协议',
                    onTap: () {
                      // TODO: 跳转到用户协议页面
                    },
                  ),
                  _buildListTile(
                    context,
                    icon: Icons.privacy_tip,
                    title: '隐私政策',
                    subtitle: '查看隐私政策',
                    onTap: () {
                      // TODO: 跳转到隐私政策页面
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            
            // 退出登录按钮
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _showLogoutDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.error,
                  foregroundColor: AppColors.textInverse,
                ),
                child: const Text('退出登录'),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color? textColor,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: textColor ?? AppColors.primary,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: textColor?.withOpacity(0.7) ?? AppColors.textSecondary,
        ),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('退出登录'),
        content: const Text('确定要退出登录吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('取消'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: 实现退出登录逻辑
              context.go('/login');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: AppColors.textInverse,
            ),
            child: const Text('退出'),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('删除账户'),
        content: const Text(
          '删除账户是不可逆的操作，所有数据将被永久删除。确定要继续吗？',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('取消'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: 实现删除账户逻辑
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('账户删除功能待实现'),
                  backgroundColor: AppColors.warning,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: AppColors.textInverse,
            ),
            child: const Text('删除'),
          ),
        ],
      ),
    );
  }
} 