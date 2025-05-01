import 'package:flutter/material.dart';
import 'package:DevLance/core/constants/route_names.dart';

class ChooseOptionPage extends StatefulWidget {
  const ChooseOptionPage({super.key});

  @override
  State<ChooseOptionPage> createState() => _ChooseOptionPageState();
}

class _ChooseOptionPageState extends State<ChooseOptionPage> {
  String? _selectedOption;
  String? _username;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _username = ModalRoute.of(context)?.settings.arguments as String?;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Your Role'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset('assets/images/Logo.png', width: 100, height: 100),
            const SizedBox(height: 40),
            _buildOptionCard(
              title: "I'm a developer, looking for work",
              isSelected: _selectedOption == 'developer',
              onTap: () => setState(() => _selectedOption = 'developer'),
            ),
            const SizedBox(height: 20),
            _buildOptionCard(
              title: "I'm a client, hiring for a project",
              isSelected: _selectedOption == 'client',
              onTap: () => setState(() => _selectedOption = 'client'),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: _selectedOption != null ? _navigateBasedOnRole : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4AC5DE),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Continue',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateBasedOnRole() {
    if (_selectedOption == 'developer') {
      Navigator.pushNamed(
        context,
        RouteNames.developerInfo,
        arguments: _username,
      );
    } else {
      Navigator.pushNamed(
        context,
        RouteNames.clientInfo,
        arguments: _username,
      );
    }
  }

  Widget _buildOptionCard({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: isSelected ? 4 : 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: isSelected ? const Color(0xFF4AC5DE) : Colors.grey.shade200,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(
                isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                color: const Color(0xFF4AC5DE),
              ),
              const SizedBox(width: 16),
              Expanded(child: Text(title)),
            ],
          ),
        ),
      ),
    );
  }
}