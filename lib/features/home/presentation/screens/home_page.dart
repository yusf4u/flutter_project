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

  @override
  void initState() {
    super.initState();
    
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0, 0.5, curve: Curves.easeIn),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.95, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.3, 1, curve: Curves.elasticOut),
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                child: const Text(
                  'Explore Jobs',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF004F8C),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ScaleTransition(
              scale: _scaleAnimation,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: GridView.count(
                  crossAxisCount: 3,
                  childAspectRatio: 0.85,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  children: _jobCategories.map((item) {
                    return _buildCategoryCard(item);
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 32),
            FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset('assets/images/Logo.png', width: 80, height: 80),
                      Row(
                        children: [
                          _buildSocialButton('assets/images/instagram.png'),
                          const SizedBox(width: 8),
                          _buildSocialButton('assets/images/facebook.png'),
                        ],
                      ),
                    ],
                  ),
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

  Widget _buildCategoryCard(Map<String, String> item) {
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
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF004F8C), Color(0xFF4AC5DE)],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    item['icon']!,
                    width: 48,
                    height: 48,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    item['name']!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
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

  Widget _buildSocialButton(String imagePath) {
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey[200],
        ),
        child: Image.asset(imagePath, width: 24, height: 24),
      ),
    );
  }

  final List<Map<String, String>> _jobCategories = const [
    {'name': 'Websites', 'icon': 'assets/images/website.png'},
    {'name': 'Applications', 'icon': 'assets/images/mobile.png'},
    {'name': 'AI Specialist', 'icon': 'assets/images/ai.png'},
    {'name': 'Game development', 'icon': 'assets/images/games.png'},
    {'name': 'Software development', 'icon': 'assets/images/software.png'},
    {'name': 'Support & Cybersecurity', 'icon': 'assets/images/cybersecurity.png'},
    {'name': 'API/Backend', 'icon': 'assets/images/api.png'},
    {'name': 'Embedded system', 'icon': 'assets/images/embeddedsystem.png'},
    {'name': 'IT', 'icon': 'assets/images/it.png'},
    {'name': 'E-commerce development', 'icon': 'assets/images/ecommerce.png'},
    {'name': 'Data Science', 'icon': 'assets/images/datascience.png'},
    {'name': 'System Testing', 'icon': 'assets/images/systemtesting.png'},
  ];
}