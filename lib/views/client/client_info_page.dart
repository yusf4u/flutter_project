import 'package:flutter/material.dart';
import 'package:DevLance/core/constants/route_names.dart';
import 'package:DevLance/features/shared/models/profile_args.dart';

class ClientInfoPage extends StatefulWidget {
  const ClientInfoPage({super.key, String? username});  // Removed username parameter

  @override
  State<ClientInfoPage> createState() => _ClientInfoPageState();
}

class _ClientInfoPageState extends State<ClientInfoPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    // Removed the automatic company name assignment
    _nameController.addListener(_validateForm);
    _companyController.addListener(_validateForm);
    _countryController.addListener(_validateForm);
    _bioController.addListener(_validateForm);
  }

  void _validateForm() {
    setState(() {
      _isFormValid = _nameController.text.isNotEmpty &&
          _companyController.text.isNotEmpty &&
          _countryController.text.isNotEmpty &&
          _bioController.text.isNotEmpty;
    });
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        const CircleAvatar(
          radius: 40,
          backgroundColor: Color(0xFFE0F7FA),
          child: Icon(Icons.person, size: 40, color: Color(0xFF4AC5DE)),
        ),
        const SizedBox(height: 16),
        Text(
          'Complete Your Profile',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Help developers know more about you',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text('Client Profile'),
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
                    controller: _companyController,
                    label: 'Company Name',
                    icon: Icons.business_outlined,
                  ),
                  _buildInputField(
                    controller: _countryController,
                    label: 'Country',
                    icon: Icons.location_on_outlined,
                  ),
                  _buildInputField(
                    controller: _bioController,
                    label: 'About You/Company Bio',
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
                            arguments: ProfileArgs(
                              fullName: _nameController.text,
                              bio: _bioController.text,
                              degreeOrCompany: _companyController.text,
                              country: _countryController.text,
                              role: 'client',
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