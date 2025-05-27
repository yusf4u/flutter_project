import 'package:flutter/material.dart';
import 'package:DevLance/views/jobs/job_details.dart';
import 'package:DevLance/core/constants/route_names.dart';

class WebsitesPage extends StatefulWidget {
  const WebsitesPage({super.key});

  @override
  State<WebsitesPage> createState() => _WebsitesPageState();
}

class _WebsitesPageState extends State<WebsitesPage> {
  // List to store all jobs
  final List<Map<String, dynamic>> _jobs = [
    {
      'title': 'Website for clothes page',
      'description': 'I want to create a modern and user-friendly website for my clothing brand. The website should showcase our latest collections, include an e-commerce functionality, and have a blog section for fashion tips.',
      'rating': 4.7,
      'location': 'United States',
      'time': '20 min ago',
      'price': 30,
      'skills': ['HTML/CSS', 'JavaScript', 'React', 'E-commerce'],
    },
    {
      'title': 'Website for Shopping Mall',
      'description': 'I want a modern, user-friendly website for my shopping mall that includes store directories, promotions, events calendar, and interactive mall map. The design should be elegant and easy to navigate.',
      'rating': 4.4,
      'location': 'Dubai UAE',
      'time': '15 min ago',
      'price': 70,
      'skills': ['HTML/CSS', 'JavaScript', 'Angular', 'UI/UX'],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final userType = ModalRoute.of(context)?.settings.arguments as String?;

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
              )),
          ),
          toolbarHeight: 80,
          elevation: 0,
          title: Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                border: InputBorder.none,
                icon: Icon(Icons.search),
              ),
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications, color: Colors.white),
              onPressed: () {},
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
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, RouteNames.home);
              },
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
            _buildDrawerItem(
              icon: Icons.info,
              title: 'About',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, RouteNames.about);
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
            const Divider(),
            _buildDrawerItem(
              icon: Icons.logout,
              title: 'Logout',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  RouteNames.start,
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Websites Jobs',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (userType == 'client')
                  ElevatedButton(
                    onPressed: () {
                      _showPostJobDialog(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF004F8C),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Post Job',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                if (userType == 'developer')
                  ElevatedButton(
                    onPressed: () {
                      _showDeveloperWarning(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF004F8C),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Post Job',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 20),
            // Display all jobs from the list
            ..._jobs.map((job) => Column(
              children: [
                _buildJobCard(
                  context: context,
                  title: job['title'],
                  description: job['description'],
                  rating: job['rating'],
                  location: job['location'],
                  time: job['time'],
                  price: job['price'],
                  skills: List<String>.from(job['skills']),
                ),
                const SizedBox(height: 20),
              ],
            )),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Logout',
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
          } else if (index == 2) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              RouteNames.start,
              (route) => false,
            );
          }
        },
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

  void _showPostJobDialog(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    final detailsController = TextEditingController();
    final deadlineController = TextEditingController();
    final budgetController = TextEditingController();
    final skillController = TextEditingController();
    List<String> skills = [];

    bool isFormValid() {
      return titleController.text.isNotEmpty &&
          descriptionController.text.isNotEmpty &&
          detailsController.text.isNotEmpty &&
          deadlineController.text.isNotEmpty &&
          budgetController.text.isNotEmpty &&
          skills.isNotEmpty;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Post a Job'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Share your job request by filling this requirements.',
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: titleController,
                      onChanged: (_) => setState(() {}),
                      decoration: const InputDecoration(
                        labelText: 'Title job',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: descriptionController,
                      maxLines: 3,
                      maxLength: 250,
                      onChanged: (_) => setState(() {}),
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        border: OutlineInputBorder(),
                        hintText: 'Please keep your message under 250 characters',
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: detailsController,
                      maxLines: 2,
                      onChanged: (_) => setState(() {}),
                      decoration: const InputDecoration(
                        labelText: 'Details',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: deadlineController,
                      onChanged: (_) => setState(() {}),
                      decoration: const InputDecoration(
                        labelText: 'Deadline',
                        border: OutlineInputBorder(),
                        hintText: 'M/D/Y 00:00 PM',
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: budgetController,
                      onChanged: (_) => setState(() {}),
                      decoration: const InputDecoration(
                        labelText: 'Set your budget',
                        border: OutlineInputBorder(),
                        prefixText: '\$ ',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),
                    // Skills Section
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Required Skills',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: skillController,
                                decoration: const InputDecoration(
                                  labelText: 'Add skill',
                                  border: OutlineInputBorder(),
                                  hintText: 'Enter skill and press +',
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                if (skillController.text.isNotEmpty) {
                                  setState(() {
                                    skills.add(skillController.text);
                                    skillController.clear();
                                  });
                                }
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        if (skills.isNotEmpty)
                          Wrap(
                            spacing: 8,
                            runSpacing: 4,
                            children: skills.map((skill) => Chip(
                              label: Text(skill),
                              backgroundColor: const Color(0xFFE3F2FD),
                              deleteIcon: const Icon(Icons.close, size: 16),
                              onDeleted: () {
                                setState(() {
                                  skills.remove(skill);
                                });
                              },
                            )).toList(),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: isFormValid()
                      ? () {
                          // Add the new job to the list
                          setState(() {
                            _jobs.insert(0, {
                              'title': titleController.text,
                              'description': descriptionController.text,
                              'rating': 0.0, // New job has no rating yet
                              'location': 'Cairo,Egypt', // Default location
                              'time': 'Just now',
                              'price': int.tryParse(budgetController.text) ?? 0,
                              'skills': List<String>.from(skills),
                            });
                          });
                          
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Job posted successfully!')),
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF004F8C),
                    disabledBackgroundColor: Colors.grey,
                  ),
                  child: const Text(
                    'Share',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showDeveloperWarning(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Warning'),
          content: const Text("You can't post a job while you are a developer."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildJobCard({
    required BuildContext context,
    required String title,
    required String description,
    required double rating,
    required String location,
    required String time,
    required int price,
    required List<String> skills,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      rating.toString(),
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      location,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      time,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: skills.map((skill) => Chip(
                label: Text(skill),
                backgroundColor: const Color(0xFFE3F2FD),
                labelStyle: const TextStyle(color: Color(0xFF1976D2)),
              )).toList(),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F5E9),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '\$$price',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E7D32),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => JobDetailsPage(
                          jobTitle: title,
                          description: description,
                          rating: rating,
                          location: location,
                          price: price,
                          time: time,
                          skills: skills,
                          title: '',
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF004F8C),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'View Details',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}