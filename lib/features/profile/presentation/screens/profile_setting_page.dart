import 'package:flutter/material.dart';
import 'package:DevLance/core/constants/route_names.dart';
import 'package:DevLance/features/shared/models/profile_args.dart';


class ProfileSettingPage extends StatefulWidget {
  final ProfileArgs? profileArgs;
  
  const ProfileSettingPage({super.key, this.profileArgs});

  @override
  State<ProfileSettingPage> createState() => _ProfileSettingPageState();
}

class _ProfileSettingPageState extends State<ProfileSettingPage> {
  late List<String> skills;
  late List<String> jobHistory;
  final TextEditingController skillController = TextEditingController();
  final TextEditingController jobController = TextEditingController();
  double accountBalance = 1250.50;

  @override
  void initState() {
    super.initState();
    skills = widget.profileArgs?.skills ?? ['Flutter', 'Dart', 'UI/UX'];
    jobHistory = widget.profileArgs?.jobHistory ?? ['Senior Developer at TechCo (2020-2023)'];
  }

  @override
  void dispose() {
    skillController.dispose();
    jobController.dispose();
    super.dispose();
  }

  void _addSkill() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Skill', style: TextStyle(color: Color(0xFF4AC5DE))),
        content: TextField(
          controller: skillController,
          decoration: InputDecoration(
            hintText: 'Enter your skill',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF4AC5DE)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF4AC5DE), width: 2),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4AC5DE),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              if (skillController.text.trim().isNotEmpty) {
                setState(() {
                  skills.add(skillController.text.trim());
                  skillController.clear();
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Add', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _deleteSkill(int index) {
    setState(() => skills.removeAt(index));
  }

  void _addJobHistory() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Job History', style: TextStyle(color: Color(0xFF4AC5DE))),
        content: TextField(
          controller: jobController,
          decoration: InputDecoration(
            hintText: 'Enter job history',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF4AC5DE)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF4AC5DE), width: 2),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4AC5DE),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              if (jobController.text.trim().isNotEmpty) {
                setState(() {
                  jobHistory.add(jobController.text.trim());
                  jobController.clear();
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Add', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _deleteJobHistory(int index) {
    setState(() => jobHistory.removeAt(index));
  }

  void _navigateToEditProfile() {
    if (widget.profileArgs?.role == 'developer') {
      Navigator.pushNamed(
        context,
        RouteNames.developerInfo,
        arguments: ProfileArgs(
          fullName: widget.profileArgs?.fullName ?? '',
          bio: widget.profileArgs?.bio ?? '',
          degreeOrCompany: widget.profileArgs?.degreeOrCompany ?? '',
          country: widget.profileArgs?.country ?? '',
          role: 'developer',
          skills: skills,
          jobHistory: jobHistory,
        ),
      );
    }
  }

  void _withdrawFunds() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Withdraw Funds', style: TextStyle(color: Color(0xFF4AC5DE))),
        content: const Text('Withdrawal functionality will be implemented here'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK', style: TextStyle(color: Color(0xFF4AC5DE))),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Color(0xFF4AC5DE)),
            onPressed: _navigateToEditProfile,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Profile Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFF4AC5DE).withOpacity(0.3),
                            width: 2,
                          ),
                        ),
                        child: ClipOval(
                          child: widget.profileArgs?.imagePath != null
                              ? Image.network(
                                  widget.profileArgs!.imagePath!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => 
                                      const Icon(Icons.person, size: 50, color: Color(0xFF4AC5DE)),
                                )
                              : const Icon(Icons.person, size: 50, color: Color(0xFF4AC5DE)),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: const Color(0xFF4AC5DE),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                            ),
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    widget.profileArgs?.fullName ?? 'Your Name',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (widget.profileArgs?.bio != null && widget.profileArgs!.bio!.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      widget.profileArgs!.bio!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                  const SizedBox(height: 12),
                  if (widget.profileArgs?.country != null && widget.profileArgs!.country!.isNotEmpty) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 16,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          widget.profileArgs!.country!,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                  if (widget.profileArgs?.degreeOrCompany != null && widget.profileArgs!.degreeOrCompany!.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.school,
                          size: 16,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          widget.profileArgs!.degreeOrCompany!,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Skills Section
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Your Skills',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.add_circle, color: Color(0xFF4AC5DE)),
                        onPressed: _addSkill,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  if (skills.isEmpty)
                    const Text(
                      'No skills added yet',
                      style: TextStyle(color: Colors.grey),
                    )
                  else
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: skills.map((skill) => Chip(
                        label: Text(skill),
                        backgroundColor: const Color(0xFF4AC5DE).withOpacity(0.1),
                        deleteIcon: const Icon(Icons.close, size: 16, color: Color(0xFF4AC5DE)),
                        onDeleted: () => _deleteSkill(skills.indexOf(skill)),
                        labelStyle: const TextStyle(color: Color(0xFF4AC5DE)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(color: Color(0xFF4AC5DE)),
                        ),
                      )).toList(),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Job History Section
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Job History',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.add_circle, color: Color(0xFF4AC5DE)),
                        onPressed: _addJobHistory,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  if (jobHistory.isEmpty)
                    const Text(
                      'No job history added yet',
                      style: TextStyle(color: Colors.grey),
                    )
                  else
                    Column(
                      children: jobHistory.map((job) => Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4AC5DE).withOpacity(0.05),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFF4AC5DE).withOpacity(0.2),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xFF4AC5DE).withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.work_outline,
                                color: Color(0xFF4AC5DE),
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                job,
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.delete_outline,
                                color: Colors.red,
                              ),
                              onPressed: () => _deleteJobHistory(jobHistory.indexOf(job)),
                            ),
                          ],
                        ),
                      )).toList(),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Account Balance Section
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Account Balance',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Text(
                      '\$${accountBalance.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4AC5DE),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _withdrawFunds,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4AC5DE),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Withdraw Funds',
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
          ],
        ),
      ),
    );
  }
}