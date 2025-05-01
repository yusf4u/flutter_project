import 'package:flutter/material.dart';
import 'package:DevLance/features/jobs/presentation/screens/job_details.dart';

class WebsitesPage extends StatelessWidget {
  const WebsitesPage({super.key});

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
              ),
            ),
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
              icon: const Icon(Icons.notifications),
              onPressed: () {},
            )
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF004F8C)),
              child: Text('Menu', style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/home');
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                final args = ModalRoute.of(context)?.settings.arguments;
                Navigator.pushNamed(
                  context,
                  '/profile-setting',
                  arguments: args is String ? args : null,
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
            _buildJobCard(
              context: context,
              title: 'Website for clothes page',
              description:
                  'I want to create a modern and user-friendly website for my clothing brand. The website should showcase our latest collections, include an e-commerce functionality, and have a blog section for fashion tips.',
              rating: 4.7,
              location: 'United States',
              time: '20 min ago',
              price: 30,
            ),
            const SizedBox(height: 20),
            _buildJobCard(
              context: context,
              title: 'Website for Shopping Mall',
              description:
                  'I want a modern, user-friendly website for my shopping mall that includes store directories, promotions, events calendar, and interactive mall map. The design should be elegant and easy to navigate.',
              rating: 4.4,
              location: 'Dubai UAE',
              time: '15 min ago',
              price: 70,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          if (index == 1) {
            final args = ModalRoute.of(context)?.settings.arguments;
            Navigator.pushNamed(
              context,
              '/profile-setting',
              arguments: args is String ? args : null,
            );
          }
        },
      ),
    );
  }

  void _showPostJobDialog(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    final detailsController = TextEditingController();
    final deadlineController = TextEditingController();
    final budgetController = TextEditingController();

    bool isFormValid() {
      return titleController.text.isNotEmpty &&
          descriptionController.text.isNotEmpty &&
          detailsController.text.isNotEmpty &&
          deadlineController.text.isNotEmpty &&
          budgetController.text.isNotEmpty;
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