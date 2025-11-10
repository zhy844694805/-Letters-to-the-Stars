import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'starry_sky_page.dart';

void main() {
  runApp(const HuiXiangApp());
}

class HuiXiangApp extends StatelessWidget {
  const HuiXiangApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '回响',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.light(
          primary: const Color(0xFF8FB28F),
          secondary: const Color(0xFFE8B4BC),
          surface: const Color(0xFFF5F5F0),
          background: const Color(0xFFF5F5F0),
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F5F0),
        fontFamily: 'PingFang SC',
      ),
      home: const HomePage(),
    );
  }
}

// 纪念对象数据模型
class Memorial {
  final String name;
  final String type; // 'person' or 'pet'
  final String date;
  final String? imageUrl;
  final Color accentColor;

  Memorial({
    required this.name,
    required this.type,
    required this.date,
    this.imageUrl,
    required this.accentColor,
  });
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _fabController;
  late TextEditingController _searchController;

  String _selectedFilter = 'all'; // 'all', 'person', 'pet'
  String _searchQuery = '';

  // 示例数据
  final List<Memorial> _allMemorials = [
    Memorial(
      name: '外婆',
      type: 'person',
      date: '1935.03.15 - 2022.11.08',
      accentColor: const Color(0xFFE8B4BC),
    ),
    Memorial(
      name: '小白',
      type: 'pet',
      date: '2015.06.20 - 2023.02.14',
      accentColor: const Color(0xFFA8D5BA),
    ),
    Memorial(
      name: '爷爷',
      type: 'person',
      date: '1932.08.22 - 2021.05.30',
      accentColor: const Color(0xFFD4C5E8),
    ),
    Memorial(
      name: '旺财',
      type: 'pet',
      date: '2018.01.10 - 2024.03.05',
      accentColor: const Color(0xFFFFE4B5),
    ),
    Memorial(
      name: '奶奶',
      type: 'person',
      date: '1940.12.05 - 2020.06.18',
      accentColor: const Color(0xFFFFB6C1),
    ),
    Memorial(
      name: '咪咪',
      type: 'pet',
      date: '2019.08.30 - 2024.01.22',
      accentColor: const Color(0xFFB4E7CE),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _fabController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _searchController = TextEditingController();
    _fabController.forward();
  }

  @override
  void dispose() {
    _fabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  // 获取过滤后的纪念列表
  List<Memorial> get _filteredMemorials {
    return _allMemorials.where((memorial) {
      // 类型筛选
      if (_selectedFilter != 'all' && memorial.type != _selectedFilter) {
        return false;
      }
      // 搜索筛选
      if (_searchQuery.isNotEmpty &&
          !memorial.name.toLowerCase().contains(_searchQuery.toLowerCase())) {
        return false;
      }
      return true;
    }).toList();
  }

  // 统计数据
  int get _totalCount => _allMemorials.length;
  int get _personCount => _allMemorials.where((m) => m.type == 'person').length;
  int get _petCount => _allMemorials.where((m) => m.type == 'pet').length;

  @override
  Widget build(BuildContext context) {
    final filteredMemorials = _filteredMemorials;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // 自定义顶部栏
          SliverAppBar(
            expandedHeight: 240,
            floating: false,
            pinned: true,
            backgroundColor: const Color(0xFFE8F5E8),
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color(0xFFE8F5E8),
                      const Color(0xFFF5F5F0).withOpacity(0.8),
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    // 切换主题按钮
                    Positioned(
                      top: 50,
                      right: 16,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.nightlight_round),
                          color: const Color(0xFF4A5A4A),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const StarrySkyPage(),
                              ),
                            );
                          },
                          tooltip: '切换到星空主题',
                        ),
                      ),
                    ),
                    // 装饰性花朵元素
                    Positioned(
                      top: 40,
                      right: 70,
                      child: _buildDecorativeFlower(
                        color: const Color(0xFFE8B4BC).withOpacity(0.3),
                        size: 80,
                      ),
                    ),
                    Positioned(
                      top: 80,
                      left: 40,
                      child: _buildDecorativeFlower(
                        color: const Color(0xFFA8D5BA).withOpacity(0.3),
                        size: 60,
                      ),
                    ),
                    // 标题和统计
                    Positioned(
                      left: 24,
                      bottom: 80,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '回响',
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w300,
                              color: const Color(0xFF4A5A4A),
                              letterSpacing: 4,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '永远的思念，永恒的爱',
                            style: TextStyle(
                              fontSize: 14,
                              color: const Color(0xFF8A9A8A),
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // 统计信息
                    Positioned(
                      left: 24,
                      right: 24,
                      bottom: 20,
                      child: _buildStatistics(),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 搜索栏
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: _buildSearchBar(),
            ),
          ),

          // 分类筛选
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: _buildFilterChips(),
            ),
          ),

          // 纪念卡片网格或空状态
          filteredMemorials.isEmpty
              ? SliverFillRemaining(
                  child: _buildEmptyState(),
                )
              : SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                  sliver: SliverGrid(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return _buildMemorialCard(filteredMemorials[index], index);
                      },
                      childCount: filteredMemorials.length,
                    ),
                  ),
                ),
        ],
      ),

      // 添加纪念按钮
      floatingActionButton: ScaleTransition(
        scale: CurvedAnimation(
          parent: _fabController,
          curve: Curves.easeInOut,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF8FB28F).withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: FloatingActionButton.extended(
            onPressed: () {
              // TODO: 添加新的纪念
              _showAddMemorialDialog();
            },
            backgroundColor: const Color(0xFF8FB28F),
            elevation: 0,
            icon: const Icon(Icons.add, color: Colors.white),
            label: const Text(
              '添加纪念',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                letterSpacing: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // 统计信息卡片
  Widget _buildStatistics() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem('总计', _totalCount, const Color(0xFF8FB28F)),
          Container(width: 1, height: 30, color: Colors.grey.withOpacity(0.2)),
          _buildStatItem('亲人', _personCount, const Color(0xFFE8B4BC)),
          Container(width: 1, height: 30, color: Colors.grey.withOpacity(0.2)),
          _buildStatItem('宠物', _petCount, const Color(0xFFA8D5BA)),
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
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: const Color(0xFF8A9A8A),
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  // 搜索栏
  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (value) {
          setState(() {
            _searchQuery = value;
          });
        },
        decoration: InputDecoration(
          hintText: '搜索纪念...',
          hintStyle: TextStyle(
            color: const Color(0xFF8A9A8A),
            fontSize: 14,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: const Color(0xFF8FB28F),
          ),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  icon: Icon(
                    Icons.clear,
                    color: const Color(0xFF8A9A8A),
                  ),
                  onPressed: () {
                    _searchController.clear();
                    setState(() {
                      _searchQuery = '';
                    });
                  },
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }

  // 分类筛选
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
          color: isSelected ? const Color(0xFF8FB28F) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 18,
              color: isSelected ? Colors.white : const Color(0xFF8A9A8A),
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: isSelected ? Colors.white : const Color(0xFF4A5A4A),
                fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
              ),
            ),
          ],
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
          _buildDecorativeFlower(
            color: const Color(0xFFE8B4BC).withOpacity(0.3),
            size: 120,
          ),
          const SizedBox(height: 24),
          Text(
            _searchQuery.isNotEmpty ? '未找到匹配的纪念' : '还没有任何纪念',
            style: TextStyle(
              fontSize: 18,
              color: const Color(0xFF8A9A8A),
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            _searchQuery.isNotEmpty ? '尝试其他搜索关键词' : '点击下方按钮添加第一个纪念',
            style: TextStyle(
              fontSize: 14,
              color: const Color(0xFFB0B0B0),
            ),
          ),
        ],
      ),
    );
  }

  // 构建纪念卡片
  Widget _buildMemorialCard(Memorial memorial, int index) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 300 + (index * 50)),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: GestureDetector(
        onTap: () {
          _showMemorialDetail(memorial);
        },
        child: Hero(
          tag: 'memorial_${memorial.name}',
          child: Material(
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 15,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // 背景花朵装饰
                  Positioned(
                    top: -20,
                    right: -20,
                    child: _buildDecorativeFlower(
                      color: memorial.accentColor.withOpacity(0.15),
                      size: 120,
                    ),
                  ),

                  // 内容
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 类型图标
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: memorial.accentColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            memorial.type == 'person'
                                ? Icons.person_outline
                                : Icons.pets_outlined,
                            color: memorial.accentColor,
                            size: 24,
                          ),
                        ),

                        const Spacer(),

                        // 名字
                        Text(
                          memorial.name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF3A4A3A),
                            letterSpacing: 1,
                          ),
                        ),

                        const SizedBox(height: 8),

                        // 日期
                        Text(
                          memorial.date,
                          style: TextStyle(
                            fontSize: 12,
                            color: const Color(0xFF8A9A8A),
                            letterSpacing: 0.5,
                          ),
                        ),

                        const SizedBox(height: 16),

                        // 装饰性小花
                        Row(
                          children: List.generate(
                            3,
                            (index) => Padding(
                              padding: const EdgeInsets.only(right: 6),
                              child: _buildSmallFlower(
                                color: memorial.accentColor.withOpacity(0.6),
                                size: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // 装饰性花朵
  Widget _buildDecorativeFlower({required Color color, required double size}) {
    return CustomPaint(
      size: Size(size, size),
      painter: FlowerPainter(color: color),
    );
  }

  // 小花朵
  Widget _buildSmallFlower({required Color color, required double size}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Container(
          width: size * 0.4,
          height: size * 0.4,
          decoration: BoxDecoration(
            color: color.withOpacity(0.5),
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }

  // 显示纪念详情
  void _showMemorialDetail(Memorial memorial) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFFF5F5F0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDecorativeFlower(
              color: memorial.accentColor.withOpacity(0.5),
              size: 80,
            ),
            const SizedBox(height: 16),
            Text(
              memorial.name,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF3A4A3A),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              memorial.date,
              style: TextStyle(
                fontSize: 14,
                color: const Color(0xFF8A9A8A),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              '详情页面开发中...',
              style: TextStyle(
                fontSize: 14,
                color: const Color(0xFF8A9A8A),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              '关闭',
              style: TextStyle(
                color: const Color(0xFF8FB28F),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 显示添加纪念对话框
  void _showAddMemorialDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFFF5F5F0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDecorativeFlower(
              color: const Color(0xFF8FB28F).withOpacity(0.5),
              size: 80,
            ),
            const SizedBox(height: 16),
            Text(
              '添加纪念',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF3A4A3A),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              '添加功能开发中...',
              style: TextStyle(
                fontSize: 14,
                color: const Color(0xFF8A9A8A),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              '关闭',
              style: TextStyle(
                color: const Color(0xFF8FB28F),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 自定义花朵绘制器
class FlowerPainter extends CustomPainter {
  final Color color;

  FlowerPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);
    final petalRadius = size.width / 4;

    // 绘制5个花瓣
    for (int i = 0; i < 5; i++) {
      final angle = (i * 72) * math.pi / 180;
      final petalCenter = Offset(
        center.dx + math.cos(angle) * petalRadius,
        center.dy + math.sin(angle) * petalRadius,
      );
      canvas.drawCircle(petalCenter, petalRadius, paint);
    }

    // 绘制花心
    paint.color = color.withOpacity(0.8);
    canvas.drawCircle(center, petalRadius * 0.6, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
