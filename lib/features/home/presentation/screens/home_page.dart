import 'package:flutter/material.dart';
import 'package:DevLance/core/constants/route_names.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<Color?> _titleColorAnimation;

  // List of gradient colors for each category
  final List<List<Color>> _categoryGradients = [
    [const Color(0xFF004F8C), const Color(0xFF0066B3)],
    [const Color(0xFF4AC5DE), const Color(0xFF2FB8E6)],
    [const Color(0xFF6E48AA), const Color(0xFF9D50BB)],
    [const Color(0xFF4776E6), const Color(0xFF8E54E9)],
    [const Color(0xFFEB3349), const Color(0xFFF45C43)],
    [const Color(0xFFFF8008), const Color(0xFFFFC837)],
    [const Color(0xFF1D976C), const Color(0xFF93F9B9)],
    [const Color(0xFF614385), const Color(0xFF516395)],
    [const Color(0xFF16222A), const Color(0xFF3A6073)],
    [const Color(0xFF1F1C2C), const Color(0xFF928DAB)],
    [const Color(0xFF1A2980), const Color(0xFF26D0CE)],
    [const Color(0xFF603813), const Color(0xFFB29F94)],
  ];

  @override
  void initState() {
    super.initState();
    
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0, 0.6, curve: Curves.easeInOut),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.9, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.2, 1, curve: Curves.elasticOut),
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutQuart,
      ),
    );

    _titleColorAnimation = ColorTween(
      begin: const Color(0xFF004F8C).withOpacity(0),
      end: const Color(0xFF004F8C),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.5, 1, curve: Curves.easeIn),
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/theme.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          toolbarHeight: 80,
          elevation: 0,
          title: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                border: InputBorder.none,
                icon: Icon(Icons.search, color: Colors.grey),
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
          actions: [
            ScaleTransition(
              scale: _fadeAnimation,
              child: IconButton(
                icon: Badge(
                  backgroundColor: Colors.red,
                  smallSize: 8,
                  child: const Icon(Icons.notifications, color: Colors.white),
                ),
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 160,
              decoration: const BoxDecoration(
                color: Color(0xFF004F8C),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: const Center(
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            _buildDrawerItem(
              icon: Icons.home,
              title: 'Home',
              onTap: () => Navigator.pop(context),
            ),
            _buildDrawerItem(
              icon: Icons.person,
              title: 'Profile',
              onTap: () {
                final args = ModalRoute.of(context)?.settings.arguments;
                Navigator.pushNamed(
                  context,
                  RouteNames.profileSetting,
                  arguments: args is String ? args : null,
                );
              },
            ),
// In the drawer items section of your home_page.dart
          _buildDrawerItem(
           icon: Icons.info,
            title: 'About',
     onTap: () {
    Navigator.pop(context); // Close the drawer
    Navigator.pushNamed(context, RouteNames.about);
                 },
             ),
            const Divider(),
            _buildDrawerItem(
              icon: Icons.settings,
              title: 'Settings',
              onTap: () {},
            ),
            _buildDrawerItem(
              icon: Icons.help,
              title: 'Help & Support',
              onTap: () {},
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SlideTransition(
              position: _slideAnimation,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: AnimatedBuilder(
                  animation: _titleColorAnimation,
                  builder: (context, child) {
                    return Text(
                      'Explore Categories',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: _titleColorAnimation.value,
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            ScaleTransition(
              scale: _scaleAnimation,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Column(
                  children: List.generate(_jobCategories.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _buildFullWidthCategoryCard(
                        _jobCategories[index], 
                        _categoryGradients[index % _categoryGradients.length]
                      ),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: BottomNavigationBar(
              currentIndex: 0,
              selectedItemColor: const Color(0xFF004F8C),
              unselectedItemColor: Colors.grey,
              showUnselectedLabels: true,
              backgroundColor: Colors.white,
              elevation: 10,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
              onTap: (index) {
                if (index == 1) {
                  final args = ModalRoute.of(context)?.settings.arguments;
                  Navigator.pushNamed(
                    context,
                    RouteNames.profileSetting,
                    arguments: args is String ? args : null,
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF004F8C)),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      onTap: onTap,
    );
  }

  Widget _buildFullWidthCategoryCard(Map<String, String> item, List<Color> gradientColors) {
    return GestureDetector(
      onTap: () {
        if (item['name'] == 'Websites') {
          Navigator.pushNamed(
            context,
            RouteNames.websites,
            arguments: 'client',
          );
        } else {
          Navigator.pushNamed(
            context,
            RouteNames.categoryDetails,
            arguments: item['name'],
          );
        }
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: TweenAnimationBuilder(
          duration: const Duration(milliseconds: 300),
          tween: Tween<double>(begin: 0, end: 1),
          builder: (context, value, child) {
            return Transform.scale(
              scale: value,
              child: child,
            );
          },
          child: Container(
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: gradientColors,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Stack(
              children: [
                Positioned(
                  right: 20,
                  top: 20,
                  child: Opacity(
                    opacity: 0.2,
                    child: Image.asset(
                      item['icon']!,
                      width: 80,
                      height: 80,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Image.asset(
                            item['icon']!,
                            width: 30,
                            height: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['name']!,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Tap to explore',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  final List<Map<String, String>> _jobCategories = const [
    {'name': 'Websites', 'icon': 'assets/images/website.png'},
    {'name': 'Applications', 'icon': 'assets/images/mobile.png'},
    {'name': 'AI Specialist', 'icon': 'assets/images/ai.png'},
    {'name': 'Game development', 'icon': 'assets/images/games.png'},
    {'name': 'Software development', 'icon': 'assets/images/software.png'},
    {'name': 'Cybersecurity', 'icon': 'assets/images/cybersecurity.png'},
    {'name': 'API/Backend', 'icon': 'assets/images/api.png'},
    {'name': 'Embedded', 'icon': 'assets/images/embeddedsystem.png'},
    {'name': 'IT', 'icon': 'assets/images/it.png'},
    {'name': 'E-commerce', 'icon': 'assets/images/ecommerce.png'},
    {'name': 'Data Science', 'icon': 'assets/images/datascience.png'},
    {'name': 'Testing', 'icon': 'assets/images/systemtesting.png'},
  ];
}