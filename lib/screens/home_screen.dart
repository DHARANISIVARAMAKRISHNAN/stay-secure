import 'package:flutter/material.dart';
import 'emergency_contacts_screen.dart';
import 'sos_screen.dart';
import 'women_laws_screen.dart';
import 'self_defense_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stay Secure'),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            'Welcome to Stay Secure App',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 30),

          // PANIC Button
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SosScreen()),
              );
            },
            child: Container(
              width: 160,
              height: 160,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.warning_amber_rounded,
                      color: Colors.white, size: 45),
                  SizedBox(height: 6),
                  Text(
                    'PANIC',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 30),

          // Feature grid
          Expanded(
            child: GridView.count(
              padding: const EdgeInsets.all(16),
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: [
                _featureCard(
                  context,
                  icon: Icons.contacts,
                  label: 'Emergency Contacts',
                  screen: const EmergencyContactsScreen(),
                ),
                _featureCard(
                  context,
                  icon: Icons.balance,
                  label: 'Women Laws',
                  screen: const WomenLawsScreen(),
                ),
                _featureCard(
                  context,
                  icon: Icons.sports_kabaddi,
                  label: 'Self Defense',
                  screen: const SelfDefenseScreen(),
                ),
                _featureCard(
                  context,
                  icon: Icons.local_hospital,
                  label: 'Helpline Numbers',
                  screen: const WomenLawsScreen(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _featureCard(BuildContext context,
      {required IconData icon, required String label, required Widget screen}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
      child: Card(
        elevation: 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.red),
            const SizedBox(height: 10),
            Text(label, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
