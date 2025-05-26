import 'package:flutter/material.dart';
import '../../../shared/models/profile_args.dart';

// Bank Account Page
class BankAccountPage extends StatefulWidget {
  final ProfileArgs? profileArgs;
  
  const BankAccountPage({super.key, this.profileArgs});

  @override
  State<BankAccountPage> createState() => _BankAccountPageState();
}

class _BankAccountPageState extends State<BankAccountPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _cardholderController = TextEditingController();
  final TextEditingController _expiryController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    _cardholderController.addListener(_validateForm);
    _expiryController.addListener(_validateForm);
    _cvvController.addListener(_validateForm);
    _cardNumberController.addListener(_validateForm);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.profileArgs != null) {
      _cardholderController.text = widget.profileArgs!.fullName;
    }
  }

  void _validateForm() {
    setState(() {
      _isFormValid = _cardholderController.text.isNotEmpty &&
          _expiryController.text.isNotEmpty &&
          _cvvController.text.isNotEmpty &&
          _cardNumberController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _cardholderController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    _cardNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bank Account'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.blue[800],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset(
                          'assets/images/visa.png',
                          width: 60,
                          height: 40,
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Text(
                      _cardNumberController.text.isEmpty
                          ? '**** **** **** ****'
                          : _formatCardNumber(_cardNumberController.text),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        letterSpacing: 2.0,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Cardholder Name',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              _cardholderController.text.isEmpty
                                  ? 'Your Name'
                                  : _cardholderController.text,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Expiry Date',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              _expiryController.text.isEmpty
                                  ? 'MM/YY'
                                  : _expiryController.text,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'CVV',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              _cvvController.text.isEmpty
                                  ? '***'
                                  : '•' * _cvvController.text.length,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: _cardholderController,
                decoration: const InputDecoration(
                  labelText: 'Cardholder\'s name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter cardholder name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      controller: _expiryController,
                      decoration: const InputDecoration(
                        labelText: 'Expiry Date (MM/YY)',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.calendar_today),
                      ),
                      keyboardType: TextInputType.datetime,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter expiry date';
                        }
                        if (!RegExp(r'^\d{2}/\d{2}$').hasMatch(value)) {
                          return 'Format: MM/YY';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      controller: _cvvController,
                      decoration: const InputDecoration(
                        labelText: 'CVV',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock),
                      ),
                      keyboardType: TextInputType.number,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter CVV';
                        }
                        if (value.length < 3 || value.length > 3) {
                          return 'CVV must be 3 digits';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _cardNumberController,
                decoration: const InputDecoration(
                  labelText: 'Card number',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.credit_card),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter card number';
                  }
                  if (value.length < 16 || value.length > 16) {
                    return 'Card number must be 16 digits';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _isFormValid
                    ? () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.pushNamed(
                            context,
                            '/verified-account',
                            arguments: {
                              'username': widget.profileArgs?.fullName ?? _cardholderController.text,
                              'role': widget.profileArgs?.role ?? 'developer'
                            },
                          );
                        }
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4AC5DE),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Continue',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward, size: 20, color: Colors.white),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatCardNumber(String input) {
    final stripped = input.replaceAll(RegExp(r'\s'), '');
    final buffer = StringBuffer();
    for (int i = 0; i < stripped.length; i++) {
      if (i > 0 && i % 4 == 0) {
        buffer.write(' ');
      }
      buffer.write(stripped[i]);
    }
    return buffer.toString();
  }
}
