import 'package:flutter/material.dart';
import 'package:steam_ui/ui.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Steam English - Teacher Dashboard'),
        backgroundColor: Colors.white,
        elevation: 1,
        titleTextStyle: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
            IconButton(icon: const Icon(Icons.person), onPressed: () {}),
        ],
      ),
      body: Row(
        children: [
          // Sidebar
          NavigationRail(
            selectedIndex: 0,
            onDestinationSelected: (int index) {
                if (index == 2) {
                    Navigator.of(context).pushNamed('/content');
                } else if (index == 3) {
                    Navigator.of(context).pushNamed('/projects');
                }
            },
            labelType: NavigationRailLabelType.all,
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.dashboard),
                label: Text('Dashboard'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.group),
                label: Text('Groups'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.library_books),
                label: Text('Content'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.assignment),
                label: Text('Projects'),
              ),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),
          // Main Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Overview',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                        _buildStatCard('Active Students', '28', Colors.blue),
                        const SizedBox(width: 16),
                        _buildStatCard('Pending Reviews', '5', Colors.orange),
                        const SizedBox(width: 16),
                        _buildStatCard('Groups', '12', Colors.purple),
                    ],
                  ),
                  const SizedBox(height: 48),
                  const Text(
                    'Recent Submissions',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  const Expanded(
                    child: Center(child: Text('Table placeholder...')),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
            // Navigate to Create Group
            Navigator.of(context).pushNamed('/groups/new');
        },
        label: const Text('New Group'),
        icon: const Icon(Icons.add),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
    );
  }

  Widget _buildStatCard(String title, String value, Color color) {
    return Card(
      elevation: 2,
      child: Container(
        width: 200,
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(value, style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: color)),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontSize: 16, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
