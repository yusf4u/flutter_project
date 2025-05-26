import 'package:flutter/material.dart';
import 'package:DevLance/core/constants/route_names.dart';
import '../../models/user_profile.dart';

class DeveloperInfoPage extends StatefulWidget {
  const DeveloperInfoPage({super.key, String? username});

  @override
  State<DeveloperInfoPage> createState() => _DeveloperInfoPageState();
}

class _DeveloperInfoPageState extends State<DeveloperInfoPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _degreeController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  String? _selectedInterest;
  bool _isFormValid = false;

  final List<String> _interests = [
    'Web Development',
    'Mobile Development',
    'Data Science',
    'Machine Learning',
    'DevOps',
    'UI/UX Design',
    'Game Development'
  ];

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_validateForm);
    _degreeController.addListener(_validateForm);
    _countryController.addListener(_validateForm);
    _bioController.addListener(_validateForm);
  }

  void _validateForm() {
    setState(() {
      _isFormValid = _nameController.text.isNotEmpty &&
          _degreeController.text.isNotEmpty &&
          _countryController.text.isNotEmpty &&
          _bioController.text.isNotEmpty &&
          _selectedInterest != null;
    });
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        const CircleAvatar(
          radius: 40,
          backgroundColor: Color(0xFFE0F7FA),
          child: Icon(Icons.code, size: 40, color: Color(0xFF4AC5DE)),
        ),
        const SizedBox(height: 16),
        Text(
          'Complete Developer Profile',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Showcase your skills and expertise',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey[600]),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Icon(icon, color: const Color(0xFF4AC5DE)),
          suffixIcon: controller.text.isNotEmpty
              ? const Icon(Icons.check_circle, color: Colors.green)
              : null,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: maxLines > 1 ? 16 : 0,
          ),
        ),
        maxLines: maxLines,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'This field is required';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildInterestDropdown() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: DropdownButtonFormField<String>(
        value: _selectedInterest,
        decoration: InputDecoration(
          labelText: 'Your Interest',
          labelStyle: TextStyle(color: Colors.grey[600]),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Icon(Icons.star_outline, color: const Color(0xFF4AC5DE)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        ),
        items: _interests.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (newValue) {
          setState(() {
            _selectedInterest = newValue;
            _validateForm();
          });
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select your interest';
          }
          return null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text('Developer Profile'),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            _buildProfileHeader(),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildInputField(
                    controller: _nameController,
                    label: 'Your Name',
                    icon: Icons.person_outline,
                  ),
                  _buildInputField(
                    controller: _degreeController,
                    label: 'Bachelor\'s Degree',
                    icon: Icons.school_outlined,
                  ),
                  _buildInputField(
                    controller: _countryController,
                    label: 'Country',
                    icon: Icons.location_on_outlined,
                  ),
                  _buildInterestDropdown(),
                  _buildInputField(
                    controller: _bioController,
                    label: 'About You/Professional Bio',
                    icon: Icons.info_outline,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isFormValid
                    ? () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.pushNamed(
                            context,
                            RouteNames.bankAccount,
                            arguments: UserProfile(
                              fullName: _nameController.text,
                              bio: _bioController.text,
                              degreeOrCompany: _degreeController.text,
                              country: _countryController.text,
                              role: 'developer',
                              interest: _selectedInterest,
                            ),
                          );
                        }
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4AC5DE),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0,
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
            ),
          ],
        ),
      ),
    );
  }
}