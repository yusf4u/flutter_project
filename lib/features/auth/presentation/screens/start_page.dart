import 'package:flutter/material.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _logoScale;
  late Animation<double> _titleFade;
  late Animation<Offset> _titleSlide;
  late final List<Animation<double>> _featureFades = [];
  late final List<Animation<Offset>> _featureSlides = [];

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    // Logo animation - scales up with bounce
// Logo animation - scales up with bounce
_logoScale = TweenSequence<double>([
  TweenSequenceItem(tween: Tween(begin: 0.5, end: 1.2), weight: 50), // Overshoot
  TweenSequenceItem(tween: Tween(begin: 1.2, end: 1.0), weight: 50), // Settle
]).animate(
  CurvedAnimation(
    parent: _controller,
    curve: const Interval(0.0, 0.4, curve: Curves.easeOutBack),
  ),
);

    // Title animations
    _titleFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 0.6, curve: Curves.easeIn),
      ),
    );
    _titleSlide = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 0.7, curve: Curves.easeOutQuad),
      ),
    );

    // Feature animations - staggered
    const featureCount = 5;
    for (int i = 0; i < featureCount; i++) {
      _featureFades.add(
        Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Interval(
              0.6 + (i * 0.08),
              0.8 + (i * 0.08),
              curve: Curves.easeIn,
            ),
          ),
        ),
      );
      _featureSlides.add(
        Tween<Offset>(
          begin: const Offset(-0.5, 0),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Interval(
              0.6 + (i * 0.08),
              0.9 + (i * 0.08),
              curve: Curves.easeOutBack,
            ),
          ),
        ),
      );
    }

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Color(0xFFE6F7FD)],
            stops: [0.3, 1.0],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated Logo with glow effect
                AnimatedBuilder(
                  animation: _logoScale,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _logoScale.value,
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            if (_controller.value > 0.3)
                              BoxShadow(
                                color: const Color(0xFF4AC5DE).withOpacity(0.2 * _controller.value),
                                blurRadius: 20,
                                spreadRadius: 2,
                              ),
                          ],
                        ),
                        child: child,
                      ),
                    );
                  },
                  child: Image.asset(
                    'assets/images/Logo.png',
                    width: 150,
                    height: 150,
                  ),
                ),
                const SizedBox(height: 30),
                
                // Animated Title with subtle parallax
                AnimatedBuilder(
                  animation: Listenable.merge([_titleFade, _titleSlide]),
                  builder: (context, child) {
                    return Opacity(
                      opacity: _titleFade.value,
                      child: Transform.translate(
                        offset: _titleSlide.value * 50,
                        child: child,
                      ),
                    );
                  },
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        height: 1.4,
                        color: Color(0xFF004F8C),
                      ),
children: [
  TextSpan(text: 'Your Platform for\n'),
  TextSpan(
    text: 'Freelance Excellence',
    style: TextStyle(
      color: Color(0xFF4AC5DE),
    ),
  ),
],
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                
                // Animated Feature List with polished icons
                _buildFeatureList(),
                const SizedBox(height: 50),
                
                // Buttons with ripple animation
                _buildAuthButtons(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureList() {
    final features = [
      _FeatureItem(
        icon: Icons.rocket_launch_rounded,
        color: const Color(0xFF6E48AA),
        title: 'Project Management',
        description: 'Manage projects with our intuitive dashboard',
      ),
      _FeatureItem(
        icon: Icons.attach_money_rounded,
        color: const Color(0xFF1D976C),
        title: 'Competitive Pricing',
        description: 'Get the best value for your budget',
      ),
      _FeatureItem(
        icon: Icons.chat_bubble_rounded,
        color: const Color(0xFFEB3349),
        title: 'Seamless Communication',
        description: 'Built-in chat and collaboration tools',
      ),
      _FeatureItem(
        icon: Icons.security_rounded,
        color: const Color(0xFFFF8008),
        title: 'Data Protection',
        description: 'Enterprise-grade security for your projects',
      ),
      _FeatureItem(
        icon: Icons.auto_awesome_rounded,
        color: const Color(0xFF4776E6),
        title: 'Focus on Creativity',
        description: 'We handle the logistics - you create',
      ),
    ];

    return Column(
      children: features.asMap().entries.map((entry) {
        final index = entry.key;
        final feature = entry.value;
        
        return AnimatedBuilder(
          animation: Listenable.merge([_featureFades[index], _featureSlides[index]]),
          builder: (context, child) {
            return Opacity(
              opacity: _featureFades[index].value,
              child: Transform.translate(
                offset: _featureSlides[index].value * 100,
                child: child,
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              elevation: _controller.value > 0.6 + (index * 0.08) ? 2 : 0,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: feature.color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        feature.icon,
                        color: feature.color,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            feature.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            feature.description,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                              height: 1.4,
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
        );
      }).toList(),
    );
  }

  Widget _buildAuthButtons(BuildContext context) {
    return Column(
      children: [
        // Sign Up Button with gradient
        Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF4AC5DE), Color(0xFF004F8C)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF4AC5DE).withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/signup'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              padding: const EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const SizedBox(
              width: double.infinity,
              child: Text(
                'Get Started - Sign Up Free',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Sign In Button
        OutlinedButton(
          onPressed: () => Navigator.pushNamed(context, '/signin'),
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Color(0xFF4AC5DE)),
            backgroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: const SizedBox(
            width: double.infinity,
            child: Text(
              'I Have An Account - Sign In',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF4AC5DE),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        // Guest Option
        TextButton(
          onPressed: () {},
          child: const Text(
            'Continue as Guest',
            style: TextStyle(
              color: Color(0xFF004F8C),
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}

class _FeatureItem {
  final IconData icon;
  final Color color;
  final String title;
  final String description;

  _FeatureItem({
    required this.icon,
    required this.color,
    required this.title,
    required this.description,
  });
}