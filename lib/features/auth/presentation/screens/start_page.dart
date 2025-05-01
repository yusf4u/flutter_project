import 'package:flutter/material.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _logoAnimation;
  late Animation<double> _titleAnimation;
  late final List<Animation<double>> _featureAnimations = [];

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    // Logo animation - slides down from top
    _logoAnimation = Tween<double>(begin: -100, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.3, curve: Curves.easeOut),
      ),
    );

    // Title animation - fades in
    _titleAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.5, curve: Curves.easeIn),
      ),
    );

    // Feature items animations - staggered
    const featureCount = 5;
    for (int i = 0; i < featureCount; i++) {
      _featureAnimations.add(
        Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Interval(
              0.5 + (i * 0.1),
              0.7 + (i * 0.1),
              curve: Curves.easeIn,
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
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animated Logo
              AnimatedBuilder(
                animation: _logoAnimation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, _logoAnimation.value),
                    child: Opacity(
                      opacity: _controller.value >= 0.3 ? 1.0 : 0.0,
                      child: child,
                    ),
                  );
                },
                child: Image.asset(
                  'assets/images/Logo.png',
                  width: 120,
                  height: 120,
                ),
              ),
              const SizedBox(height: 30),
              
              // Animated Title
              AnimatedBuilder(
                animation: _titleAnimation,
                builder: (context, child) {
                  return Opacity(
                    opacity: _titleAnimation.value,
                    child: Transform.translate(
                      offset: Offset(0, 20 * (1 - _titleAnimation.value)),
                      child: child,
                    ),
                  );
                },
                child: const Text(
                  'Your platform for running your freelance business\neasily and professionally.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    height: 1.4,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              
              // Animated Feature List
              _buildFeatureList(),
              const SizedBox(height: 50),
              
              // Buttons (no animation)
              _buildAuthButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureList() {
    const features = [
      'Manage projects easily.',
      'Access to the best value for money.',
      'Ease of communication between client and developer.',
      'Your privacy and data security are our priorities.',
      'Free up your time and focus on creativity – we take care of the rest.',
    ];

    return Column(
      children: features.asMap().entries.map((entry) {
        final index = entry.key;
        final feature = entry.value;
        
        return AnimatedBuilder(
          animation: _featureAnimations[index],
          builder: (context, child) {
            return Opacity(
              opacity: _featureAnimations[index].value,
              child: Transform.translate(
                offset: Offset(20 * (1 - _featureAnimations[index].value), 0),
                child: child,
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 4.0, right: 12.0),
                  child: Icon(Icons.check_circle, color: Colors.cyan[600], size: 20),
                ),
                Expanded(
                  child: Text(
                    feature,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildAuthButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/signin');
            },
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFF4AC5DE)),
              backgroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Sign In',
              style: TextStyle(
                color: Color(0xFF4AC5DE),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/signup');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4AC5DE),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Sign Up',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}