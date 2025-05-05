import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        title: const Text(
          'DevLance',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Color(0xFF004F8C),
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Color(0xFF004F8C)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Logo at the top
            Center(
              child: Hero(
                tag: 'app-logo',
                child: Image.asset(
                  'assets/images/Logo.png',
                  width: 120,
                  height: 120,
                ),
              ),
            ),
            const SizedBox(height: 24),
            
            // What is DevLance? section
            _buildSectionContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'What is DevLance?',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF004F8C),
                    ),
                  ),
                  const SizedBox(height: 12),
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
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // Features section
            _buildSectionContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Our Features',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF004F8C),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildFeatureItem(Icons.code, 'Wide Range of Tech Categories'),
                  _buildFeatureItem(Icons.verified_user, 'Verified Professionals'),
                  _buildFeatureItem(Icons.rocket_launch, 'Quick Project Deployment'),
                  _buildFeatureItem(Icons.security, 'Secure Transactions'),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // Team section
            _buildSectionContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Our Team',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF004F8C),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'We are a passionate team of developers, designers, and entrepreneurs '
                    'dedicated to creating the best platform for tech professionals and '
                    'businesses to collaborate effectively.\n\n'
                    'Youssef Mohamed\n'
                    'Mohamed Zaghloul\n'
                    'Mohamed Mahmoud\n'
                    'Mazen Mamdouh\n'
                    'Ahmed Emad',
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.6,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // Connect with us section
            _buildSectionContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Connect With Us',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF004F8C),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Follow us on social media to stay updated with our latest news and offerings:',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _buildSocialButton('assets/images/facebook.png', 'Facebook'),
                      const SizedBox(width: 24),
                      _buildSocialButton('assets/images/instagram.png', 'Instagram'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            
            // Footer
            Center(
              child: Text(
                '© 2025 DevLance. All rights reserved.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionContainer({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF004F8C).withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF004F8C).withOpacity(0.1),
          width: 1,
        ),
      ),
      child: child,
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
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
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
              width: 24,
              height: 24,
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