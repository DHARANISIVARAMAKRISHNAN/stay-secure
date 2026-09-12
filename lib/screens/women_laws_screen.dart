import 'package:flutter/material.dart';

class WomenLawsScreen extends StatelessWidget {
  const WomenLawsScreen({super.key});

  final List<Map<String, String>> _laws = const [
    {
      'title': 'Sexual Harassment of Women at Workplace Act, 2013',
      'desc':
          'Protects women from harassment at the workplace and provides a mechanism for complaints.'
    },
    {
      'title': 'Domestic Violence Act, 2005',
      'desc':
          'Provides protection to women facing domestic violence, including physical, emotional, or economic abuse.'
    },
    {
      'title': 'Dowry Prohibition Act, 1961',
      'desc': 'Prohibits the giving and taking of dowry.'
    },
    {
      'title': 'IPC Section 354',
      'desc': 'Deals with assault or criminal force against a woman with intent to outrage her modesty.'
    },
    {
      'title': 'IPC Section 509',
      'desc': 'Punishes words, gestures, or acts intended to insult the modesty of a woman.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Women Law Awareness'),
        backgroundColor: Colors.red,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: _laws.length,
        itemBuilder: (context, index) {
          final law = _laws[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    law['title']!,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 6),
                  Text(law['desc']!),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
