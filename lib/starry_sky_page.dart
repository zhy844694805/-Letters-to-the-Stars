import 'package:flutter/material.dart';
import 'dart:math' as math;

// 纪念对象数据模型
class Memorial {
  final String name;
  final String type; // 'person' or 'pet'
  final String date;
  final String? imageUrl;
  final Color accentColor;
  final Offset position; // 星星在屏幕上的位置

  Memorial({
    required this.name,
    required this.type,
    required this.date,
    this.imageUrl,
    required this.accentColor,
    required this.position,
  });
}

class StarrySkyPage extends StatefulWidget {
  const StarrySkyPage({super.key});

  @override
  State<StarrySkyPage> createState() => _StarrySkyPageState();
}

class _StarrySkyPageState extends State<StarrySkyPage>
    with TickerProviderStateMixin {
  late AnimationController _twinkleController;
  late AnimationController _floatController;

  String _selectedFilter = 'all'; // 'all', 'person', 'pet'

  // 示例数据（带位置信息）
  final List<Memorial> _allMemorials = [
    Memorial(
      name: '外婆',
      type: 'person',
      date: '1935.03.15 - 2022.11.08',
      accentColor: const Color(0xFFFFD700), // 金色
      position: const Offset(0.7, 0.25),
    ),
    Memorial(
      name: '小白',
      type: 'pet',
      date: '2015.06.20 - 2023.02.14',
      accentColor: const Color(0xFF87CEEB), // 天蓝色
      position: const Offset(0.3, 0.35),
    ),
    Memorial(
      name: '爷爷',
      type: 'person',
      date: '1932.08.22 - 2021.05.30',
      accentColor: const Color(0xFFFFA500), // 橙色
      position: const Offset(0.5, 0.2),
    ),
    Memorial(
      name: '旺财',
      type: 'pet',
      date: '2018.01.10 - 2024.03.05',
      accentColor: const Color(0xFF98FB98), // 淡绿色
      position: const Offset(0.15, 0.45),
    ),
    Memorial(
      name: '奶奶',
      type: 'person',
      date: '1940.12.05 - 2020.06.18',
      accentColor: const Color(0xFFDDA0DD), // 淡紫色
      position: const Offset(0.8, 0.4),
    ),
    Memorial(
      name: '咪咪',
      type: 'pet',
      date: '2019.08.30 - 2024.01.22',
      accentColor: const Color(0xFFB0E0E6), // 粉蓝色
      position: const Offset(0.6, 0.5),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _twinkleController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _floatController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _twinkleController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  // 获取过滤后的纪念列表
  List<Memorial> get _filteredMemorials {
    if (_selectedFilter == 'all') return _allMemorials;
    return _allMemorials.where((m) => m.type == _selectedFilter).toList();
  }

  // 统计数据
  int get _totalCount => _allMemorials.length;
  int get _personCount => _allMemorials.where((m) => m.type == 'person').length;
  int get _petCount => _allMemorials.where((m) => m.type == 'pet').length;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final filteredMemorials = _filteredMemorials;

    return Scaffold(
      body: Stack(
        children: [
          // 星空背景
          _buildStarryBackground(),

          // 主要内容
          SafeArea(
            child: Column(
              children: [
                // 顶部标题栏
                _buildHeader(),

                // 统计信息
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: _buildStatistics(),
                ),

                // 筛选按钮
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: _buildFilterChips(),
                ),

                // 星空展示区域
                Expanded(
                  child: filteredMemorials.isEmpty
                      ? _buildEmptyState()
                      : Stack(
                          children: [
                            // 星星
                            ...filteredMemorials.map((memorial) {
                              return _buildStar(memorial, size);
                            }).toList(),

                            // 连接线（可选）
                            CustomPaint(
                              size: size,
                              painter: ConstellationPainter(
                                memorials: filteredMemorials,
                                screenSize: size,
                              ),
                            ),
                          ],
                        ),
                ),
              ],
            ),
          ),

          // 添加纪念按钮
          Positioned(
            right: 24,
            bottom: 24,
            child: _buildFloatingButton(),
          ),
        ],
      ),
    );
  }

  // 星空背景
  Widget _buildStarryBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFF0A1128), // 深蓝黑
            const Color(0xFF1E2749), // 深蓝
            const Color(0xFF2E3856), // 蓝灰
          ],
        ),
      ),
      child: CustomPaint(
        size: Size.infinite,
        painter: BackgroundStarsPainter(
          animation: _twinkleController,
        ),
      ),
    );
  }

  // 顶部标题
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          const Text(
            '回响',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w300,
              color: Colors.white,
              letterSpacing: 4,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '每颗星都是永恒的记忆',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.7),
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }

  // 统计信息
  Widget _buildStatistics() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem('总计', _totalCount, const Color(0xFFFFD700)),
          Container(
            width: 1,
            height: 30,
            color: Colors.white.withOpacity(0.2),
          ),
          _buildStatItem('亲人', _personCount, const Color(0xFFFFA500)),
          Container(
            width: 1,
            height: 30,
            color: Colors.white.withOpacity(0.2),
          ),
          _buildStatItem('宠物', _petCount, const Color(0xFF87CEEB)),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, int count, Color color) {
    return Column(
      children: [
        Text(
          '$count',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withOpacity(0.7),
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }

  // 筛选按钮
  Widget _buildFilterChips() {
    return Row(
      children: [
        _buildFilterChip('全部', 'all', Icons.apps),
        const SizedBox(width: 12),
        _buildFilterChip('亲人', 'person', Icons.person_outline),
        const SizedBox(width: 12),
        _buildFilterChip('宠物', 'pet', Icons.pets_outlined),
      ],
    );
  }

  Widget _buildFilterChip(String label, String value, IconData icon) {
    final isSelected = _selectedFilter == value;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedFilter = value;
        });
      },
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.white.withOpacity(0.2)
              : Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? Colors.white.withOpacity(0.5)
                : Colors.white.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 18,
              color: isSelected ? Colors.white : Colors.white.withOpacity(0.6),
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: isSelected ? Colors.white : Colors.white.withOpacity(0.6),
                fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 构建星星
  Widget _buildStar(Memorial memorial, Size screenSize) {
    return Positioned(
      left: memorial.position.dx * screenSize.width,
      top: memorial.position.dy * screenSize.height,
      child: GestureDetector(
        onTap: () => _showMemorialDetail(memorial),
        child: AnimatedBuilder(
          animation: _floatController,
          builder: (context, child) {
            final floatOffset = math.sin(_floatController.value * 2 * math.pi) * 5;
            return Transform.translate(
              offset: Offset(0, floatOffset),
              child: child,
            );
          },
          child: Column(
            children: [
              // 星星光晕
              AnimatedBuilder(
                animation: _twinkleController,
                builder: (context, child) {
                  final scale = 1.0 + (_twinkleController.value * 0.3);
                  return Transform.scale(
                    scale: scale,
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            memorial.accentColor.withOpacity(0.6),
                            memorial.accentColor.withOpacity(0.2),
                            memorial.accentColor.withOpacity(0),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              // 星星核心
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: memorial.accentColor,
                  boxShadow: [
                    BoxShadow(
                      color: memorial.accentColor.withOpacity(0.8),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(
                    memorial.type == 'person'
                        ? Icons.person
                        : Icons.pets,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              // 名字标签
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: memorial.accentColor.withOpacity(0.5),
                    width: 1,
                  ),
                ),
                child: Text(
                  memorial.name,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 空状态
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.star_outline,
            size: 80,
            color: Colors.white.withOpacity(0.3),
          ),
          const SizedBox(height: 24),
          Text(
            '还没有点亮的星星',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white.withOpacity(0.7),
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '点击下方按钮添加第一颗星',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }

  // 浮动按钮
  Widget _buildFloatingButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFFD700).withOpacity(0.5),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: FloatingActionButton.extended(
        onPressed: () {
          _showAddMemorialDialog();
        },
        backgroundColor: const Color(0xFFFFD700),
        elevation: 0,
        icon: const Icon(Icons.add, color: Color(0xFF0A1128)),
        label: const Text(
          '点亮星星',
          style: TextStyle(
            color: Color(0xFF0A1128),
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }

  // 显示纪念详情
  void _showMemorialDetail(Memorial memorial) {
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
              color: memorial.accentColor.withOpacity(0.5),
              width: 2,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: memorial.accentColor,
                  boxShadow: [
                    BoxShadow(
                      color: memorial.accentColor.withOpacity(0.5),
                      blurRadius: 30,
                      spreadRadius: 10,
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(
                    memorial.type == 'person'
                        ? Icons.person
                        : Icons.pets,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                memorial.name,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                memorial.date,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                '详情页面开发中...',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
              const SizedBox(height: 24),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  '关闭',
                  style: TextStyle(
                    color: memorial.accentColor,
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

  // 显示添加对话框
  void _showAddMemorialDialog() {
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
                size: 60,
                color: Color(0xFFFFD700),
              ),
              const SizedBox(height: 16),
              const Text(
                '点亮新星星',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                '添加功能开发中...',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
              const SizedBox(height: 24),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  '关闭',
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

// 背景星星绘制器
class BackgroundStarsPainter extends CustomPainter {
  final Animation<double> animation;

  BackgroundStarsPainter({required this.animation}) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    final random = math.Random(42); // 固定种子保证星星位置一致

    // 绘制背景小星星
    for (int i = 0; i < 100; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final opacity = 0.3 + (random.nextDouble() * 0.4);
      final twinkle = math.sin((animation.value + random.nextDouble()) * 2 * math.pi);

      paint.color = Colors.white.withOpacity(opacity * (0.5 + twinkle * 0.5));
      canvas.drawCircle(
        Offset(x, y),
        1 + random.nextDouble() * 1.5,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// 星座连接线绘制器
class ConstellationPainter extends CustomPainter {
  final List<Memorial> memorials;
  final Size screenSize;

  ConstellationPainter({
    required this.memorials,
    required this.screenSize,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (memorials.length < 2) return;

    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    // 连接相邻的星星
    for (int i = 0; i < memorials.length - 1; i++) {
      final start = Offset(
        memorials[i].position.dx * screenSize.width + 20,
        memorials[i].position.dy * screenSize.height + 40,
      );
      final end = Offset(
        memorials[i + 1].position.dx * screenSize.width + 20,
        memorials[i + 1].position.dy * screenSize.height + 40,
      );

      // 只连接距离适中的星星
      final distance = (start - end).distance;
      if (distance < 200) {
        canvas.drawLine(start, end, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
