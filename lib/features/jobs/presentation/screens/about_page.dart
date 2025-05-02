import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: const Text('About DevLance'),
        centerTitle: true,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF004F8C), Color(0xFF4AC5DE)],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo at the top
            Hero(
              tag: 'app-logo',
              child: Image.asset(
                'assets/images/Logo.png',
                width: 120,
                height: 120,
              ),
            ),
            const SizedBox(height: 24),
            
            // What is DevLance? section
            const Text(
              'What is DevLance?',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF004F8C),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'DevLance is a powerful platform connecting businesses with top-tier '
              'development talent across various technology domains. Our mission is to '
              'bridge the gap between companies needing technical solutions and skilled '
              'developers who can bring those solutions to life.',
              style: TextStyle(
                fontSize: 16,
                height: 1.6,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            
            // Features section
            const Text(
              'Our Features',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF004F8C),
              ),
            ),
            const SizedBox(height: 16),
            _buildFeatureItem(Icons.code, 'Wide Range of Tech Categories'),
            _buildFeatureItem(Icons.verified_user, 'Verified Professionals'),
            _buildFeatureItem(Icons.rocket_launch, 'Quick Project Deployment'),
            _buildFeatureItem(Icons.security, 'Secure Transactions'),
            const SizedBox(height: 32),
            
            // Team section
            const Text(
              'Our Team',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF004F8C),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'We are a passionate team of developers, designers, and entrepreneurs '
              'dedicated to creating the best platform for tech professionals and '
              'businesses to collaborate effectively.\n Youssef Mohamed , Mohamed Zaghloul , Mohamed Mahmoud , Mazen Mamdouh , Ahmed Emad ',
              style: TextStyle(
                fontSize: 16,
                height: 1.6,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            
            // Connect with us section
            const Text(
              'Connect With Us',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF004F8C),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Follow us on social media to stay updated with our latest news and offerings:',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSocialButton('assets/images/facebook.png', 'Facebook'),
                const SizedBox(width: 24),
                _buildSocialButton('assets/images/instagram.png', 'Instagram'),
              ],
            ),
            const SizedBox(height: 40),
            
            // Footer
            const Text(
              '© 2023 DevLance. All rights reserved.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: const Color(0xFF4AC5DE),
            size: 28,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton(String imagePath, String label) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Image.asset(
              imagePath,
              width: 30,
              height: 30,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}