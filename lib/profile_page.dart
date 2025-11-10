import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF0A1128),
              const Color(0xFF1E2749),
              const Color(0xFF2E3856),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  // 标题
                  const Text(
                    '我的',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '个人中心与设置',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.7),
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // 用户信息卡片
                  _buildUserCard(),
                  const SizedBox(height: 24),

                  // 统计信息
                  _buildStatistics(),
                  const SizedBox(height: 32),

                  // 功能列表
                  _buildSectionTitle('功能'),
                  const SizedBox(height: 16),
                  _buildMenuItem(
                    icon: Icons.star_border,
                    title: '我的纪念',
                    subtitle: '查看所有纪念对象',
                    onTap: () {},
                  ),
                  _buildMenuItem(
                    icon: Icons.favorite_border,
                    title: '收藏',
                    subtitle: '我收藏的内容',
                    onTap: () {},
                  ),
                  _buildMenuItem(
                    icon: Icons.history,
                    title: '访问记录',
                    subtitle: '最近查看的纪念',
                    onTap: () {},
                  ),
                  const SizedBox(height: 32),

                  // 设置列表
                  _buildSectionTitle('设置'),
                  const SizedBox(height: 16),
                  _buildMenuItem(
                    icon: Icons.notifications_outlined,
                    title: '通知设置',
                    subtitle: '管理通知偏好',
                    onTap: () {},
                  ),
                  _buildMenuItem(
                    icon: Icons.palette_outlined,
                    title: '主题设置',
                    subtitle: '切换应用主题',
                    onTap: () {},
                  ),
                  _buildMenuItem(
                    icon: Icons.language,
                    title: '语言',
                    subtitle: '简体中文',
                    onTap: () {},
                  ),
                  _buildMenuItem(
                    icon: Icons.privacy_tip_outlined,
                    title: '隐私政策',
                    subtitle: '了解我们如何保护您的数据',
                    onTap: () {},
                  ),
                  _buildMenuItem(
                    icon: Icons.info_outline,
                    title: '关于我们',
                    subtitle: '版本 1.0.0',
                    onTap: () {},
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.white.withOpacity(0.9),
        letterSpacing: 1,
      ),
    );
  }

  Widget _buildUserCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFFFD700).withOpacity(0.2),
            const Color(0xFFFFA500).withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFFFD700).withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFFFD700).withOpacity(0.3),
            ),
            child: const Icon(
              Icons.person,
              size: 32,
              color: Color(0xFFFFD700),
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '访客用户',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '点击登录或注册',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: Colors.white.withOpacity(0.5),
          ),
        ],
      ),
    );
  }

  Widget _buildStatistics() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard('6', '纪念对象', Icons.star),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard('12', '留言', Icons.message),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard('30', '访问', Icons.visibility),
        ),
      ],
    );
  }

  Widget _buildStatCard(String value, String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 24,
            color: const Color(0xFFFFD700),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: Colors.white.withOpacity(0.8),
            size: 20,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withOpacity(0.6),
          ),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: Colors.white.withOpacity(0.4),
        ),
      ),
    );
  }
}
