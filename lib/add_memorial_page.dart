import 'package:flutter/material.dart';

class AddMemorialPage extends StatefulWidget {
  const AddMemorialPage({super.key});

  @override
  State<AddMemorialPage> createState() => _AddMemorialPageState();
}

class _AddMemorialPageState extends State<AddMemorialPage> {
  String _selectedType = 'person'; // 'person' or 'pet'

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
                    '点亮新星星',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '为他/她在星空中留下永恒的记忆',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.7),
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // 类型选择
                  _buildSectionTitle('选择类型'),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTypeCard(
                          'person',
                          Icons.person,
                          '亲人',
                          const Color(0xFFFFA500),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildTypeCard(
                          'pet',
                          Icons.pets,
                          '宠物',
                          const Color(0xFF87CEEB),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // 姓名输入
                  _buildSectionTitle('姓名'),
                  const SizedBox(height: 12),
                  _buildTextField(
                    hint: '请输入姓名',
                    icon: Icons.edit,
                  ),
                  const SizedBox(height: 24),

                  // 生日
                  _buildSectionTitle('生日'),
                  const SizedBox(height: 12),
                  _buildTextField(
                    hint: '例如：1990.01.01',
                    icon: Icons.cake,
                  ),
                  const SizedBox(height: 24),

                  // 离世日期
                  _buildSectionTitle('离世日期'),
                  const SizedBox(height: 12),
                  _buildTextField(
                    hint: '例如：2024.01.01',
                    icon: Icons.event,
                  ),
                  const SizedBox(height: 24),

                  // 照片上传
                  _buildSectionTitle('照片（可选）'),
                  const SizedBox(height: 12),
                  _buildPhotoUpload(),
                  const SizedBox(height: 24),

                  // 留言
                  _buildSectionTitle('留言（可选）'),
                  const SizedBox(height: 12),
                  _buildTextField(
                    hint: '写下你想说的话...',
                    icon: Icons.message,
                    maxLines: 4,
                  ),
                  const SizedBox(height: 40),

                  // 提交按钮
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: 保存数据
                        _showSuccessDialog();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFD700),
                        foregroundColor: const Color(0xFF0A1128),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.star, size: 24),
                          SizedBox(width: 8),
                          Text(
                            '点亮星星',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
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

  Widget _buildTypeCard(String type, IconData icon, String label, Color color) {
    final isSelected = _selectedType == type;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedType = type;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.2) : Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? color : Colors.white.withOpacity(0.2),
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 48,
              color: isSelected ? color : Colors.white.withOpacity(0.5),
            ),
            const SizedBox(height: 12),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: isSelected ? color : Colors.white.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String hint,
    required IconData icon,
    int maxLines = 1,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: TextField(
        maxLines: maxLines,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.white.withOpacity(0.4),
          ),
          prefixIcon: Icon(
            icon,
            color: Colors.white.withOpacity(0.5),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
        ),
      ),
    );
  }

  Widget _buildPhotoUpload() {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 2,
          style: BorderStyle.solid,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_photo_alternate,
              size: 48,
              color: Colors.white.withOpacity(0.5),
            ),
            const SizedBox(height: 8),
            Text(
              '点击上传照片',
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF1E2749),
                const Color(0xFF2E3856),
              ],
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: const Color(0xFFFFD700).withOpacity(0.5),
              width: 2,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.star,
                size: 64,
                color: Color(0xFFFFD700),
              ),
              const SizedBox(height: 16),
              const Text(
                '星星点亮成功',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '已在星空中为Ta点亮一颗星',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 24),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  '确定',
                  style: TextStyle(
                    color: Color(0xFFFFD700),
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
